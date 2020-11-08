class_name NonPlayer
extends Character

var player
var maze: Maze
var viewing_distance: int
var hearing: int
var was_running: bool = false

func _init(texture: Texture, name: String, initial_position: Vector2, player, maze, vision: int, hearing: int, speed: float, initial_health: int, max_alpha: float).(texture, name, initial_position, speed, initial_health, max_alpha) -> void:
	self.player = player
	self.maze = maze
	viewing_distance = vision * Maze.TILE_SIZE
	self.hearing = hearing

func get_point_path_to(target: Vector2) -> PoolVector2Array:
	var path = maze.astar.get_point_path(maze.astar.get_closest_point(position), maze.astar.get_closest_point(target))
	if !path.empty():
		path.remove(0)
	return path

func player_is_visible() -> bool:
	if (!player.invisible or !is_in_group(ENEMY_GROUP)) and position.distance_to(player.position) <= viewing_distance:
		cast_ray_to(position.direction_to(player.position) * viewing_distance)
		return ray.is_colliding() and ray.get_collider().name == PLAYER_NAME
	else:
		return false

func player_is_audible(path: PoolVector2Array) -> bool:
	# We use the length of the path and not a detection area because it feels wrong that the mob (or ally) travels half
	# the maze just because it thinks it heard something (this would also imply a perfect knowledge of the labyrinth)
	return path.size() <= hearing

func player_is_perceptible(path: PoolVector2Array) -> bool:
	return player_is_audible(path) or player_is_visible()

func enemy_is_ahead(ahead: Vector2) -> bool:
	cast_ray_to(position.direction_to(ahead) * 2 * Maze.TILE_SIZE)
	# Enemies are supposed to avoid colliding with the Unicorn (as if it were a member of their own group) because
	# its special ability is to keep evil away...
	return ray.is_colliding() and (ray.get_collider().is_in_group(ENEMY_GROUP) or ray.get_collider().name == UNICORN_NAME)

func follow_path(path: PoolVector2Array, movement_type: int, maximum_path_length: int, stop_before_enemies: bool = true, advance_while_searching_player: bool = true) -> void:
	was_running = movement_type == MovementType.RUN
	var path_length = path.size()
	if path_length > maximum_path_length:
		path_length = maximum_path_length
	for i in range(path_length):
		var point = path[i]
		if ongoing_collision or (stop_before_enemies and enemy_is_ahead(point)):
			break
		move_tween_to(point, movement_type)
		yield(tween, "tween_all_completed")
		if advance_while_searching_player and player_is_visible():
			break # we exit the loop to allow the method consumer to decide what to do (e.g. update the path)

func teleport_to(target_position: Vector2) -> void:
	phasing = true
	move_tween_to(target_position, MovementType.RUN, true)
	yield(tween, "tween_all_completed")
	phasing = false

func teleport_while_healing_to(target_position: Vector2) -> void:
	teleport_to(target_position)
	if health < max_health:
		health += 1
		emit_signal("health_changed", self, health)
