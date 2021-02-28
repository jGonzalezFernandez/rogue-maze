class_name Bat
extends MobileEnemy

const TEXTURE_PATH = ResourcePath.MOBILE_ENEMIES + "/bat/bat.png"
const TEXTURE = preload(TEXTURE_PATH)

const NAME = "Bat"
const VISION = 4
const HEARING = 3
const MIN_TIME_BETWEEN_WALKS = 4.0
const MAX_WALK_LENGTH = 10
const SPEED = 3.0
const INITIAL_HEALTH = 4
const ATK = 3
const SLASHING_DEF = 0
const BLUNT_DEF = 0

func _init(initial_position: Vector2, player, maze: Maze, main: Node) \
.(initial_position, player, maze, main, TEXTURE, NAME, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass
