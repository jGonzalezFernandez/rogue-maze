class_name MobileEnemy
extends CorporealEnemy

const FRIENDLY_FIRE = 2
const IS_IMMOBILE = false

func _init(texture: Texture, name: String, initial_position: Vector2, player, maze: Maze, vision: int, hearing: int, min_time_between_walks: float, max_walk_length: int, speed: float, initial_health: int, atk: int, slashing_def: int, blunt_def: int).(texture, name, initial_position, player, maze, vision, hearing, IS_IMMOBILE, min_time_between_walks, max_walk_length, speed, initial_health, atk, FRIENDLY_FIRE, slashing_def, blunt_def) -> void:
	pass
