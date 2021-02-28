class_name ImmobileEnemy
extends CorporealEnemy

const VISION = 0
const HEARING = 0
const IS_IMMOBILE = true
const MIN_TIME_BETWEEN_WALKS = 0
const MAX_WALK_LENGTH = 0
const SPEED = 3.5 # to compute the bounce duration

func _init(initial_position: Vector2, player, maze: Maze, main: Node, texture: Texture, name: String, initial_health: int, atk: int, slashing_def: int, blunt_def: int, friendly_fire: int) \
.(initial_position, player, maze, main, texture, name, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, initial_health, atk, slashing_def, blunt_def, friendly_fire, IS_IMMOBILE) -> void:
	pass
