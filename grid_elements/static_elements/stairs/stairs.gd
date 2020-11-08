class_name Stairs
extends StaticElement

const TEXTURE = preload("res://grid_elements/static_elements/stairs/stairs.png")

func _init(position: Vector2).(TEXTURE, position) -> void:
	pass

func _ready() -> void:
	connect("area_entered", get_parent(), "stairs_reached")
