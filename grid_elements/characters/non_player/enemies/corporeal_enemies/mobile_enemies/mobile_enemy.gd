class_name MobileEnemy
extends CorporealEnemy

const FRIENDLY_FIRE = 2
const IS_IMMOBILE = false

func _init(initial_position: Vector2, player, maze: Maze, main: Node, texture: Texture, name: String, vision: int, hearing: int, min_time_between_walks: float, max_walk_length: int, speed: float, initial_health: int, atk: int, slashing_def: int, blunt_def: int) \
.(initial_position, player, maze, main, texture, name, vision, hearing, min_time_between_walks, max_walk_length, speed, initial_health, atk, slashing_def, blunt_def, FRIENDLY_FIRE, IS_IMMOBILE) -> void:
	pass
