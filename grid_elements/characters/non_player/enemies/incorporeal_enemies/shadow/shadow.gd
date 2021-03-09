class_name Shadow
extends IncorporealEnemy

const TEXTURE_PATH = ResourcePath.INCORPOREAL_ENEMIES + "/shadow/shadow.png"
const TEXTURE = preload(TEXTURE_PATH)

const VISION = 5
const HEARING = 4
const MIN_TIME_BETWEEN_WALKS = 1.0
const MAX_WALK_LENGTH = 6
const SPEED = 2.0
const INITIAL_HEALTH = 10
const ATK = 8
const SLASHING_DEF = 4
const BLUNT_DEF = 6
const STOPS_BEFORE_UNICORNS = true

func _init(initial_position: Vector2, player, maze: Maze, main: Node) \
.(initial_position, player, maze, main, TEXTURE, SHADOW_NAME, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF, STOPS_BEFORE_UNICORNS) -> void:
	pass

func special_movement() -> void:
	if Utils.twenty_five_percent_chance():
		teleport_to(maze.random_position())
	else:
		emit_signal("minor_enemy_addition_requested", ShadowClone.new(position, player, maze, main))
		walk_through_walls(Utils.get_random_elem(DIAGONALS), half_walk_length)
