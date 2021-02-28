class_name Thing
extends GridElement

const MAX_ALPHA = 1.0

func _init(position: Vector2, main: Node, texture: Texture).(position, main, texture, MAX_ALPHA) -> void:
	collision_layer = compute_layers([])
