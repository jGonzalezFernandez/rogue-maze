class_name SkeletonWizard
extends NormalEnemy

const TEXTURE = preload("res://grid_elements/characters/non_player/enemies/normal_enemies/skeleton_wizard/skeleton_wizard.png")
const NAME = "Skeleton Wizard"
const VISION = 5
const HEARING = 4
const MIN_TIME_BETWEEN_WALKS = 2.0
const MAX_WALK_LENGTH = 6
const SPEED = 3.0
const INITIAL_HEALTH = 8
const ATK = 6
const SLASHING_DEF = 2
const BLUNT_DEF = 0

func _init(initial_position: Vector2, player, maze: Maze).(TEXTURE, NAME, initial_position, player, maze, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass

func special_movement() -> void:
	teleport_while_healing_to(maze.random_position())
