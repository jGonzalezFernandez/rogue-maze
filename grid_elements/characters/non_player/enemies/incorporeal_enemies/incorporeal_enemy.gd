class_name IncorporealEnemy
extends Enemy

const DIAGONALS = [Vector2(1, -1), Vector2(1, 1), Vector2(-1, 1), Vector2(-1, -1)]

const MAX_ALPHA = 0.80
const FRIENDLY_FIRE = 2
const IS_IMMOBILE = false

func _init(texture: Texture, name: String, initial_position: Vector2, player, maze: Maze, vision: int, hearing: int, min_time_between_walks: float, max_walk_length: int, speed: float, initial_health: int, atk: int, slashing_def: int, blunt_def: int).(texture, name, initial_position, player, maze, vision, hearing, IS_IMMOBILE, min_time_between_walks, max_walk_length, speed, initial_health, atk, FRIENDLY_FIRE, slashing_def, blunt_def, MAX_ALPHA) -> void:
	collision_layer = compute_layers([Layer.SPECTRES])

func walk_through_walls(dir: Vector2, maximum_path_length: int) -> void:
	phasing = true
	for _i in range(maximum_path_length):
		var target = position + dir * maze.TILE_SIZE
		if player_is_visible() or maze.target_is_outside_boundaries(target):
			break
		move_tween_to(target, MovementType.WALK, true)
		yield(tween, "tween_all_completed")
	phasing = false
