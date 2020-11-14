class_name Character
extends GridElement

signal health_changed
signal died

enum MovementType {RUN, WALK, COLLISION}

# Some names need to be known by the whole hierarchy (and we don't want cyclic dependency errors...)
const PLAYER_NAME = "Solène"
const EVIL_TWIN_NAME = "Evil " + PLAYER_NAME
const UNICORN_NAME = "Unicorn"
const ENEMY_GROUP = "enemies"
const SHADOW_NAME = "Shadow"
const CLONE_NAME = "Clone"

var running_duration: float
var walking_duration: float
var collision_duration: float
var bounce_duration: float
var ongoing_collision = false
var health: int
var max_health: int
var phasing = false

var ray: RayCast2D

func set_durations(speed: float) -> void:
	running_duration = 1.0/speed
	walking_duration = running_duration + 0.25
	collision_duration = 1.5 * walking_duration
	bounce_duration = collision_duration / 2.0

func _init(texture: Texture, name: String, initial_position: Vector2, speed: float, initial_health: int, max_alpha: float).(texture, initial_position, max_alpha) -> void:
	self.name = name
	set_durations(speed)
	health = initial_health
	max_health = health

func _ready() -> void:
	connect("health_changed", get_parent(), "on_character_health_changed")
	connect("died", get_parent(), "on_character_died")
	
	ray = RayCast2D.new()
	ray.position = Vector2(10, 10)
	ray.collide_with_areas = true
	add_child(ray)

func get_stats() -> String:
	return String() # default implementation. Will be overridden by descendants when necessary

func move_tween_to(target_position: Vector2, movement_type: int, invisible_transition: bool = false) -> void:
	var duration: float
	var transition_type = Tween.TRANS_SINE
	var ease_type = Tween.EASE_IN_OUT
	
	match movement_type:
		MovementType.RUN:
			duration = running_duration
		MovementType.WALK:
			duration = walking_duration
		_:
			duration = collision_duration
			transition_type = Tween.TRANS_BOUNCE
			ease_type = Tween.EASE_OUT

	tween.interpolate_property(self, "position", position, target_position, duration, transition_type, ease_type)
	if invisible_transition: # we remove the alpha component of the color to make the node transparent and we put it back
		tween.interpolate_property(self, "modulate:a", 0.0, max_alpha, duration, transition_type, ease_type)
	tween.start()

func cast_ray_to(target: Vector2) -> void:
	ray.cast_to = target
	ray.force_raycast_update()

func snap(vector2: Vector2) -> Vector2:
	return vector2.snapped(Vector2.ONE * Maze.TILE_SIZE)

func move_tween_if_possible_to(target_cell: Vector2, movement_type: int, invisible_transition: bool = false) -> bool:
	# To be used when we need to avoid walls. The returned boolean indicates if the movement has happened
	cast_ray_to(target_cell)
	if !ray.is_colliding():
		move_tween_to(snap(position + target_cell), movement_type, invisible_transition)
		return true
	else:
		return false

func bounce_tween(dir: Vector2) -> void: # two pixels
	tween.interpolate_property(self, "position", position + 2 * dir, snap(position), bounce_duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween.start()

func collide(dir: Vector2) -> void:
	ongoing_collision = true
	if !move_tween_if_possible_to(dir * Maze.TILE_SIZE, MovementType.COLLISION):
		bounce_tween(dir)
	yield(tween, "tween_all_completed")
	ongoing_collision = false

func manage_collision(character: Area2D, damage: int) -> void:
	if phasing:
		health -= Utils.rounded_half(damage)
	else:
		health -= damage
		if character.position.x < position.x:
			collide(Vector2.RIGHT)
		elif character.position.x > position.x:
			collide(Vector2.LEFT)
		elif character.position.y > position.y:
			collide(Vector2.UP)
		else:
			collide(Vector2.DOWN)
	emit_signal("health_changed", self, health)
	if health <= 0:
		emit_signal("died", self)
