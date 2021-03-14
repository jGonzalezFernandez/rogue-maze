class_name MonsterGhost
extends IncorporealEnemy

const TEXTURE_PATH = ResourcePath.INCORPOREAL_ENEMIES + "/monster_ghost/monster_ghost.png"
const TEXTURE = preload(TEXTURE_PATH)

const NAME = "Monster Ghost"
const VISION = 5
const HEARING = 4
const MIN_TIME_BETWEEN_WALKS = 2.0
const MAX_WALK_LENGTH = 6
const SPEED = 2.0
const INITIAL_HEALTH = 8
const ATK = 6
const SLASHING_DEF = 4
const BLUNT_DEF = 5
const STOPS_BEFORE_UNICORNS = true

func _init(initial_position: Vector2, player, maze: Maze, main: Node) \
.(initial_position, player, maze, main, TEXTURE, NAME, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF, STOPS_BEFORE_UNICORNS) -> void:
	pass

func special_movement() -> void:
	walk_through_walls(Utils.get_random_elem(DIAGONALS), half_walk_length)
