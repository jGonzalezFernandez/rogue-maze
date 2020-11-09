class_name Spider
extends NormalEnemy

const TEXTURE_PATH = ResourcePath.NORMAL_ENEMIES + "/spider/spider.png"
const TEXTURE = preload(TEXTURE_PATH)

const NAME = "Spider"
const VISION = 4
const HEARING = 3
const MIN_TIME_BETWEEN_WALKS = 10.0
const MAX_WALK_LENGTH = 3
const SPEED = 2.5
const INITIAL_HEALTH = 6
const ATK = 4
const SLASHING_DEF = 0
const BLUNT_DEF = 0

func _init(initial_position: Vector2, player, maze: Maze).(TEXTURE, NAME, initial_position, player, maze, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass
