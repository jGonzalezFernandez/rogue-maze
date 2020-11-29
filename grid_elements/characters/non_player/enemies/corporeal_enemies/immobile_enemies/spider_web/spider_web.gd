class_name SpiderWeb
extends ImmobileEnemy

const TEXTURE_PATH = ResourcePath.IMMOBILE_ENEMIES + "/spider_web/spider_web.png"
const TEXTURE = preload(TEXTURE_PATH)

const INITIAL_HEALTH = 6
const ATK = 0
const FRIENDLY_FIRE = 0
const SLASHING_DEF = 0
const BLUNT_DEF = 1

func _init(initial_position: Vector2, player, maze: Maze).(TEXTURE, SPIDER_WEB_NAME, initial_position, player, maze, INITIAL_HEALTH, ATK, FRIENDLY_FIRE, SLASHING_DEF, BLUNT_DEF) -> void:
	pass
