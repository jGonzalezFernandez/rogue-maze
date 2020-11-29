class_name ImmobileEnemy
extends CorporealEnemy

const VISION = 0
const HEARING = 0
const IS_IMMOBILE = true
const MIN_TIME_BETWEEN_WALKS = 0
const MAX_WALK_LENGTH = 0
const SPEED = 3.5 # to compute the bounce duration

func _init(texture: Texture, name: String, initial_position: Vector2, player, maze: Maze, initial_health: int, atk: int, friendly_fire: int, slashing_def: int, blunt_def: int).(texture, name, initial_position, player, maze, VISION, HEARING, IS_IMMOBILE, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, initial_health, atk, friendly_fire, slashing_def, blunt_def) -> void:
	pass
