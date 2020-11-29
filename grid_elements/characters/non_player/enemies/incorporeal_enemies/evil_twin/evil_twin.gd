class_name EvilTwin
extends IncorporealEnemy

const TEXTURE_PATH = ResourcePath.INCORPOREAL_ENEMIES + "/evil_twin/evil_twin.png"
const TEXTURE = preload(TEXTURE_PATH)

const VISION = 15
const HEARING = 14
const MIN_TIME_BETWEEN_WALKS = 1.0
const MAX_WALK_LENGTH = 6
const SPEED = 2.0
const INITIAL_HEALTH = 10
const ATK = 8
const SLASHING_DEF = 2
const BLUNT_DEF = 4

func _init(initial_position: Vector2, player, maze: Maze).(TEXTURE, EVIL_TWIN_NAME, initial_position, player, maze, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass

func special_movement() -> void:
	if Utils.twenty_five_percent_chance():
		teleport_to(maze.random_position())
	else:
		walk_through_walls(Utils.get_random_elem(DIAGONALS), half_walk_length)
