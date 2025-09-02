class_name Minotaur
extends MobileEnemy

const TEXTURE_PATH = ResourcePath.MOBILE_ENEMIES + "/minotaur/minotaur.png"
const TEXTURE = preload(TEXTURE_PATH)

const NAME = "Minotaur"
const VISION = 5
const HEARING = 4
const MIN_TIME_BETWEEN_WALKS = 4.0
const MAX_WALK_LENGTH = 6
const SPEED = 3.0
const INITIAL_HEALTH = 8
const ATK = 6
const SLASHING_DEF = 0
const BLUNT_DEF = 1

func _init(initial_position: Vector2, player, maze: Maze, main: Node) \
.(initial_position, player, maze, main, TEXTURE, NAME, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass
