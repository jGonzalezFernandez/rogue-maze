class_name SkeletonKnight
extends NormalEnemy

const TEXTURE_PATH = ResourcePath.NORMAL_ENEMIES + "/skeleton_knight/skeleton_knight.png"
const TEXTURE = preload(TEXTURE_PATH)

const NAME = "Skeleton Knight"
const VISION = 5
const HEARING = 4
const MIN_TIME_BETWEEN_WALKS = 2.0
const MAX_WALK_LENGTH = 6
const SPEED = 3.0
const INITIAL_HEALTH = 8
const ATK = 6
const SLASHING_DEF = 4
const BLUNT_DEF = 0

func _init(initial_position: Vector2, player, maze: Maze).(TEXTURE, NAME, initial_position, player, maze, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass

# TODO: Add dash ability?
