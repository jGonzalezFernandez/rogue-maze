class_name Spider
extends MobileEnemy

const TEXTURE_PATH = ResourcePath.MOBILE_ENEMIES + "/spider/spider.png"
const TEXTURE = preload(TEXTURE_PATH)

const VISION = 4
const HEARING = 3
const MIN_TIME_BETWEEN_WALKS = 10.0
const MAX_WALK_LENGTH = 3
const SPEED = 2.5
const INITIAL_HEALTH = 6
const ATK = 4
const SLASHING_DEF = 1
const BLUNT_DEF = 1

func _init(initial_position: Vector2, player, maze: Maze, main: Node) \
.(initial_position, player, maze, main, TEXTURE, SPIDER_NAME, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass

func collision_received(sender: String, collider_position: Vector2) -> void:
	if !tween.is_active() and (sender == WEB_NAME):
		hunt(get_point_path_to(collider_position))
