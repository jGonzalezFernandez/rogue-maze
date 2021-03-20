class_name Character
extends GridElement

signal health_changed
signal died

enum MovementType {RUN, WALK, COLLISION}

# Some names need to be known by the whole hierarchy (since the 'is' operator can cause cyclic dependency errors...)
const PLAYER_NAME = "Solène"
const EVIL_TWIN_NAME = "Evil " + PLAYER_NAME
const UNICORN_NAME = "Unicorn"
const ENEMY_GROUP = "enemies"
const SPIDER_NAME = "Spider"
const WEB_NAME = "Web"
const SHADOW_NAME = "Shadow"
const CLONE_NAME = "Clone"

const PREVIOUS_POSITIONS_SIZE = 10

# We use char_name instead of the name property of Node, because Godot changes this String to make it unique when 
# more than one instance exists at the same time, but we don't want to display @ and numbers in the GUI
var char_name: String
var previous_positions = []
var running_duration: float
var walking_duration: float
var collision_duration: float
var bounce_duration: float
var ongoing_collision = false
var health: int
var max_health: int
var friendly_fire: int
var phasing = false

func set_durations(speed: float) -> void:
	running_duration = 1.0/speed
	walking_duration = running_duration + 0.25
	collision_duration = 1.5 * walking_duration
	bounce_duration = collision_duration / 2.0

func _init(initial_position: Vector2, main: Node, texture: Texture, name: String, speed: float, initial_health: int, friendly_fire: int, max_alpha: float) \
.(initial_position, main, texture, max_alpha) -> void:
	self.char_name = name
	set_durations(speed)
	health = initial_health
	max_health = health
	self.friendly_fire = friendly_fire

func _ready() -> void:
	connect("health_changed", main, "on_character_health_changed")
	connect("died", main, "on_character_died")
	ray.collide_with_areas = true

func get_stats() -> String:
	return String() # default implementation. Will be overridden by descendants when necessary

func append_to_previous_positions(previous_position: Vector2) -> void:
	if previous_positions.size() >= PREVIOUS_POSITIONS_SIZE:
		previous_positions.pop_front()
	previous_positions.append(previous_position)

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
	
	append_to_previous_positions(position)
	tween.start()

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

func teleport_to(target_position: Vector2) -> void:
	phasing = true
	move_tween_to(target_position, MovementType.RUN, true)
	yield(tween, "tween_all_completed")
	phasing = false

func increase_health_if_possible(increment: int) -> bool:
	if health < max_health:
		if increment >= max_health - health:
			health = max_health
		else:
			health += increment
		emit_signal("health_changed", self, health)
		return true
	else:
		return false

func teleport_while_healing_to(target_position: Vector2) -> void:
	teleport_to(target_position)
	increase_health_if_possible(Utils.rounded_half(max_health))

func bounce_tween(dir: Vector2) -> void: # two pixels
	tween.interpolate_property(self, "position", position + 2 * dir, snap(position), bounce_duration, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween.start()

func collide(dir: Vector2, slight_recoil: bool) -> void:
	ongoing_collision = true
	if slight_recoil or !move_tween_if_possible_to(dir * Maze.TILE_SIZE, MovementType.COLLISION):
		bounce_tween(dir)
	yield(tween, "tween_all_completed")
	ongoing_collision = false

func manage_collision(character: Area2D, damage: int, slight_recoil: bool) -> void:
	if phasing:
		damage = Utils.rounded_half(damage)
	else:
		if character.position.x < position.x:
			collide(Vector2.RIGHT, slight_recoil)
		elif character.position.x > position.x:
			collide(Vector2.LEFT, slight_recoil)
		elif character.position.y > position.y:
			collide(Vector2.UP, slight_recoil)
		else:
			collide(Vector2.DOWN, slight_recoil)
	if damage > 0:
		health -= damage
		emit_signal("health_changed", self, health)
	if health <= 0:
		emit_signal("died", self)
