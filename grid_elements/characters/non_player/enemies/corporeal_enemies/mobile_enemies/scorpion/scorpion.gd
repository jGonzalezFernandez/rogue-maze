class_name Scorpion
extends MobileEnemy

const TEXTURE_PATH = ResourcePath.MOBILE_ENEMIES + "/scorpion/scorpion.png"
const TEXTURE = preload(TEXTURE_PATH)

const NAME = "Scorpion"
const VISION = 4
const HEARING = 3
const MIN_TIME_BETWEEN_WALKS = 6.0
const MAX_WALK_LENGTH = 6
const SPEED = 2.5
const INITIAL_HEALTH = 6
const ATK = 5
const SLASHING_DEF = 1
const BLUNT_DEF = 1

func _init(initial_position: Vector2, player, maze: Maze, main: Node) \
.(initial_position, player, maze, main, TEXTURE, NAME, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass
