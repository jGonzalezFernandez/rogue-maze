class_name ShadowClone
extends IncorporealEnemy

const TEXTURE_PATH = ResourcePath.INCORPOREAL_ENEMIES + "/shadow_clone/shadow_clone.png"
const TEXTURE = preload(TEXTURE_PATH)

const VISION = 5
const HEARING = 4
const MIN_TIME_BETWEEN_WALKS = 2.0
const MAX_WALK_LENGTH = 4
const SPEED = 2.0
const INITIAL_HEALTH = 2
const ATK = 5
const SLASHING_DEF = 0
const BLUNT_DEF = 0
const STOPS_BEFORE_UNICORNS = true

func _init(initial_position: Vector2, player, maze: Maze, main: Node) \
.(initial_position, player, maze, main, TEXTURE, CLONE_NAME, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF, STOPS_BEFORE_UNICORNS) -> void:
	pass

func special_movement() -> void:
	walk_through_walls(Utils.get_random_elem(DIAGONALS), half_walk_length)

func player_found(sender: String) -> void:
	# The Shadow and its clones are supposed to have a shared vision (but only the clones attack mindlessly when called)
	if !tween.is_active() and (sender == SHADOW_NAME or sender == CLONE_NAME):
		hunt(get_point_path_to(player.position))
