class_name Unicorn
extends Ally

const TEXTURE_PATH = ResourcePath.ALLIES + "/unicorn/unicorn.png"
const TEXTURE = preload(TEXTURE_PATH)

const PERCEPTION = 3

func _init(initial_position: Vector2, player, maze: Maze, main: Node) -> void:
	super._init(initial_position, player, maze, main, TEXTURE, UNICORN_NAME, PERCEPTION)
	collision_layer = compute_layers([Layer.UNICORNS])
