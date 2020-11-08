class_name Bat
extends NormalEnemy

const TEXTURE = preload("res://grid_elements/characters/non_player/enemies/normal_enemies/bat/bat.png")
const NAME = "Bat"
const VISION = 4
const HEARING = 3
const MIN_TIME_BETWEEN_WALKS = 4.0
const MAX_WALK_LENGTH = 10
const SPEED = 3.0
const INITIAL_HEALTH = 4
const ATK = 2
const SLASHING_DEF = 0
const BLUNT_DEF = 0

func _init(initial_position: Vector2, player, maze: Maze).(TEXTURE, NAME, initial_position, player, maze, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass
