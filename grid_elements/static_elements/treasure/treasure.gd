class_name Treasure
extends StaticElement

const TEXTURE_PATH = ResourcePath.STATIC_ELEMENTS + "/treasure/treasure.png"
const TEXTURE = preload(TEXTURE_PATH)

func _init(position: Vector2).(TEXTURE, position) -> void:
	pass

func _ready() -> void:
	connect("area_entered", get_parent(), "treasure_reached", [self])
