class_name Shadow
extends IncorporealEnemy

const TEXTURE_PATH = ResourcePath.INCORPOREAL_ENEMIES + "/shadow/shadow.png"
const TEXTURE = preload(TEXTURE_PATH)

const VISION = 5
const HEARING = 4
const MIN_TIME_BETWEEN_WALKS = 1.0
const MAX_WALK_LENGTH = 6
const SPEED = 2.0
const STOPS_BEFORE_UNICORNS = true
const INITIAL_HEALTH = 10
const ATK = 8
const SLASHING_DEF = 2
const BLUNT_DEF = 4

func _init(initial_position: Vector2, player, maze: Maze).(TEXTURE, SHADOW_NAME, initial_position, player, maze, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, STOPS_BEFORE_UNICORNS, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass

func special_movement() -> void:
	if Utils.twenty_five_percent_chance():
		teleport_to(maze.random_position())
	else:
		emit_signal("minor_enemy_addition_requested", ShadowClone.new(position, player, maze))
		walk_through_walls(Utils.get_random_elem(DIAGONALS), half_walk_length)
