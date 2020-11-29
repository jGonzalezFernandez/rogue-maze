class_name Thing
extends GridElement

const MAX_ALPHA = 1.0

func _init(texture: Texture, position: Vector2).(texture, position, MAX_ALPHA) -> void:
	collision_layer = compute_layers([])
