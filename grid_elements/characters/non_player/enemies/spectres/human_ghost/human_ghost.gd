class_name HumanGhost
extends Spectre

const TEXTURE = preload("res://grid_elements/characters/non_player/enemies/spectres/human_ghost/human_ghost.png")
const NAME = "Human Ghost"
const VISION = 5
const HEARING = 4
const MIN_TIME_BETWEEN_WALKS = 2.0
const MAX_WALK_LENGTH = 6
const SPEED = 2.0
const INITIAL_HEALTH = 6
const ATK = 4
const SLASHING_DEF = 2
const BLUNT_DEF = 4

func _init(initial_position: Vector2, player, maze: Maze).(TEXTURE, NAME, initial_position, player, maze, VISION, HEARING, MIN_TIME_BETWEEN_WALKS, MAX_WALK_LENGTH, SPEED, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF) -> void:
	pass

func special_movement() -> void:
	walk_through_walls(Utils.get_random_elem(DIAGONALS), half_walk_length)
