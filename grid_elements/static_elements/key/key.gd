class_name Key
extends StaticElement

const TEXTURE_PATH = ResourcePath.STATIC_ELEMENTS + "/key/key.png"
const TEXTURE = preload(TEXTURE_PATH)

func _init(position: Vector2).(TEXTURE, position) -> void:
	pass

func _ready() -> void:
	connect("area_entered", get_parent(), "on_key_area_entered")
