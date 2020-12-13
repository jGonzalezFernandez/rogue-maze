class_name Enemy
extends NonPlayer

signal minor_enemy_addition_requested

const MIN_TIME_BETWEEN_GROUP_CALLS = 1.0

var is_immobile: bool
var min_time_between_walks: float
var max_walk_length: int
var half_walk_length: int
var atk: int
var slashing_def: int
var blunt_def: int

var group_call_timer: Timer
var movement_timer: Timer

func _init(texture: Texture, name: String, initial_position: Vector2, player, maze: Maze, vision: int, hearing: int, is_immobile: bool, min_time_between_walks: float, max_walk_length: int, speed: float, initial_health: int, atk: int, friendly_fire: int, slashing_def: int, blunt_def: int, max_alpha: float).(texture, name, initial_position, player, maze, vision, hearing, speed, initial_health, friendly_fire, max_alpha) -> void:
	self.is_immobile = is_immobile
	self.min_time_between_walks = min_time_between_walks
	self.max_walk_length = max_walk_length
	half_walk_length = Utils.rounded_half(max_walk_length)
	self.atk = atk
	self.slashing_def = slashing_def
	self.blunt_def = blunt_def
	add_to_group(ENEMY_GROUP)

func _ready() -> void:
	# enemies should be able to see everything in order to avoid unnecessary collisions on their paths
	ray.collision_mask = compute_layers([Layer.DEFAULT, Layer.CORPOREAL_ENEMIES, Layer.INCORPOREAL_ENEMIES, Layer.ALLIES])
	connect("area_entered", self, "on_area_entered")
	connect("minor_enemy_addition_requested", get_parent(), "add_minor_enemy_if_possible")
	
	group_call_timer = Timer.new()
	group_call_timer.one_shot = true
	add_child(group_call_timer)
	
	if !is_immobile:
		movement_timer = Timer.new()
		add_child(movement_timer)
		movement_timer.connect("timeout", self, "on_movement_timer_timeout")
		movement_timer.start(min_time_between_walks)

func hunt(path: PoolVector2Array) -> void:
	if group_call_timer.is_stopped(): # too many calls to the group can cause a message queue overflow
		get_tree().call_group(ENEMY_GROUP, "player_found", name)
		group_call_timer.start(MIN_TIME_BETWEEN_GROUP_CALLS)
	follow_path(path, MovementType.RUN, path.size())

func _process(_delta) -> void:
	if !tween.is_active(): # if the enemy is already doing something, we skip the execution to try again in the next frame
		# TODO: Check distances before calling get_point_path_to?
		var path = get_point_path_to(player.position)
		if player_is_visible():
			hunt(path)
		elif player_is_audible(path):
			if was_running:
				hunt(path) # we don't want enemies to forget why they were running, so... keep hunting
			else:
				follow_path(path, MovementType.WALK, path.size()) # investigate
		else:
			was_running = false

func special_movement() -> void:
	pass # "abstract method"

func choose_walk_length() -> int:
	if Utils.twenty_five_percent_chance():
		return half_walk_length
	else:
		return max_walk_length

func on_movement_timer_timeout() -> void:
	if !tween.is_active():
		if Utils.fifty_percent_chance(): # to make the mob more unpredictable, we don't want it to move with every timeout
			follow_path(get_point_path_to(maze.random_position()), MovementType.WALK, choose_walk_length()) # random walk
		elif Utils.fifty_percent_chance():
			special_movement()

func get_stats() -> String:
	return "|  ATK: %s  |  Slashing DEF: %s  |  Blunt DEF: %s  |" % [Utils.half(atk), Utils.half(slashing_def), Utils.half(blunt_def)]

func is_collision_exception(obj: Object) -> bool:
	return (SPIDER_NAME in name and WEB_NAME in obj.name) or (WEB_NAME in name and SPIDER_NAME in obj.name)

func on_area_entered(area) -> void:
	if area is BombExplosion:
		emit_signal("died", self)
	elif !is_collision_exception(area):
		var damage = area.friendly_fire
		if (area is Player):
			var slashing_dmg = area.slashing_atk + area.magic_atk - slashing_def
			var blunt_dmg = area.blunt_atk + area.magic_atk - blunt_def
			if slashing_dmg > blunt_dmg:
				damage = slashing_dmg
			else:
				damage = blunt_dmg
		manage_collision(area, damage, is_immobile)
		get_tree().call_group(ENEMY_GROUP, "collision_received", name, area.position)
