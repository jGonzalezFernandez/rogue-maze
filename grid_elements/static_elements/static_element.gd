class_name StaticElement # Motionless elements that only react to the Player's presence
extends GridElement

func _init(texture: Texture, position: Vector2).(texture, position) -> void:
	collision_layer = compute_layers([])
