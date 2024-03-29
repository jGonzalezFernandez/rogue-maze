class_name Bear
extends MobileEnemy

const TEXTURE_PATH = ResourcePath.MOBILE_ENEMIES + "/bear/bear.png"
const TEXTURE = preload(TEXTURE_PATH)

const NAME = "Bear"
const VISION = 5
const HEARING = 4
const MIN_TIME_BETWEEN_WALKS = 6.0
const MAX_WALK_LENGTH = 6
const SPEED = 3.0
const INITIAL_HEALTH = 8
const ATK = 6
const SLASHING_DEF = 0
const BLUNT_DEF = 1

func _init(initial_position: Vector2, player, maze: Maze, main: Node) \
.(initial_position, player, maze, main, TEXTURE, NAME, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass

# TODO: Add beehive + bees? The bees, like the clones, die in one hit, but they look for coins
