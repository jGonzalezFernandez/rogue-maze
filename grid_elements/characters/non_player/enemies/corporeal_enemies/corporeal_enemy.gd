class_name CorporealEnemy
extends Enemy

const STOPS_BEFORE_UNICORNS = true
const MAX_ALPHA = 1.0

func _init(initial_position: Vector2, player, maze: Maze, main: Node, texture: Texture, name: String, vision: int, hearing: int, min_time_between_walks: float, max_walk_length: int, speed: float, initial_health: int, atk: int, slashing_def: int, blunt_def: int, friendly_fire: int, is_immobile: bool) \
.(initial_position, player, maze, main, texture, name, vision, hearing, min_time_between_walks, max_walk_length, speed, initial_health, atk, slashing_def, blunt_def, friendly_fire, is_immobile, STOPS_BEFORE_UNICORNS, MAX_ALPHA) -> void:
	collision_layer = compute_layers([Layer.CORPOREAL_ENEMIES])
	collision_mask = compute_layers([Layer.DEFAULT, Layer.CORPOREAL_ENEMIES])
