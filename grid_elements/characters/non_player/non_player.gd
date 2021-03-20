class_name NonPlayer
extends Character

var player
var maze: Maze
var viewing_distance: int
var hearing: int
var hearing_loud_sounds: int
var was_running: bool = false

func _init(initial_position: Vector2, player, maze: Maze, main: Node, texture: Texture, name: String, vision: int, hearing: int, speed: float, initial_health: int, friendly_fire: int, max_alpha: float) \
.(initial_position, main, texture, name, speed, initial_health, friendly_fire, max_alpha) -> void:
	self.player = player
	self.maze = maze
	viewing_distance = vision * Maze.TILE_SIZE
	self.hearing = hearing
	self.hearing_loud_sounds = 3 * hearing

func get_point_path_to(target: Vector2) -> PoolVector2Array:
	var path = maze.astar.get_point_path(maze.astar.get_closest_point(position), maze.astar.get_closest_point(target))
	if !path.empty():
		path.remove(0)
	return path

func player_is_visible() -> bool:
	if is_instance_valid(player) and (!player.invisible or !is_in_group(ENEMY_GROUP)) and position.distance_to(player.position) <= viewing_distance:
		cast_ray_to(position.direction_to(player.position) * viewing_distance)
		return ray.is_colliding() and ray.get_collider() is Player
	else:
		return false

func player_is_audible(path: PoolVector2Array) -> bool:
	# We use the length of the path and not a detection area because it feels wrong that the mob (or ally) travels half
	# the maze just because it thinks it heard something (this would also imply a perfect knowledge of the labyrinth)
	return path.size() <= hearing

func player_is_perceptible(path: PoolVector2Array) -> bool:
	return player_is_audible(path) or player_is_visible()

func is_obstacle(_obj: Object) -> bool:
	return false

func is_collision_exception(_obj: Object) -> bool:
	return false

func obstacle_is_ahead(ahead: Vector2) -> bool:
	cast_ray_to(position.direction_to(ahead) * 2 * Maze.TILE_SIZE)
	if ray.is_colliding():
		var obj = ray.get_collider()
		return is_obstacle(obj) and !is_collision_exception(obj)
	else:
		return false

func follow_path(path: PoolVector2Array, movement_type: int, maximum_path_length: int, stop_before_obstacles: bool = true, advance_while_searching_player: bool = true) -> void:
	was_running = movement_type == MovementType.RUN
	var path_length = path.size()
	if path_length > maximum_path_length:
		path_length = maximum_path_length
	for i in path_length:
		var point = path[i]
		if ongoing_collision or (stop_before_obstacles and obstacle_is_ahead(point)):
			break
		move_tween_to(point, movement_type)
		yield(tween, "tween_all_completed")
		if advance_while_searching_player and player_is_visible():
			break # we exit the loop to allow the method consumer to decide what to do (e.g. update the path)
