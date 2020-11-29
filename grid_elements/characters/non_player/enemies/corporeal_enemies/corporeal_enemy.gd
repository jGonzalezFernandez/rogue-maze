class_name CorporealEnemy
extends Enemy

const MAX_ALPHA = 1.0

func _init(texture: Texture, name: String, initial_position: Vector2, player, maze: Maze, vision: int, hearing: int, is_immobile: bool, min_time_between_walks: float, max_walk_length: int, speed: float, initial_health: int, atk: int, friendly_fire: int, slashing_def: int, blunt_def: int).(texture, name, initial_position, player, maze, vision, hearing, is_immobile, min_time_between_walks, max_walk_length, speed, initial_health, atk, friendly_fire, slashing_def, blunt_def, MAX_ALPHA) -> void:
	collision_layer = compute_layers([Layer.NORMAL_ENEMIES])
	collision_mask = compute_layers([Layer.DEFAULT, Layer.NORMAL_ENEMIES])
