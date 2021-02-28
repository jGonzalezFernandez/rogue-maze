class_name Unicorn
extends Ally

const TEXTURE_PATH = ResourcePath.ALLIES + "/unicorn/unicorn.png"
const TEXTURE = preload(TEXTURE_PATH)

const VISION = 3
const HEARING = 3
const SPEED = 4.0
const INITIAL_HEALTH = -1

func _init(initial_position: Vector2, player, maze: Maze, main: Node) \
.(initial_position, player, maze, main, TEXTURE, UNICORN_NAME, VISION, HEARING, SPEED, INITIAL_HEALTH) -> void:
	pass
