class_name Treasure
extends StaticElement

const TEXTURE = preload("res://grid_elements/static_elements/treasure/treasure.png")

func _init(position: Vector2).(TEXTURE, position) -> void:
	pass

func _ready() -> void:
	connect("area_entered", get_parent(), "treasure_reached", [self])
