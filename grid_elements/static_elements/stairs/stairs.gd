class_name Stairs
extends StaticElement

const TEXTURE_PATH = ResourcePath.STATIC_ELEMENTS + "/stairs/stairs.png"
const TEXTURE = preload(TEXTURE_PATH)

func _init(position: Vector2).(TEXTURE, position) -> void:
	pass

func _ready() -> void:
	connect("area_entered", get_parent(), "stairs_reached")
