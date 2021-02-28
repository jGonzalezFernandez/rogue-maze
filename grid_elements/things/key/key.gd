class_name Key
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/key/key.png"
const TEXTURE = preload(TEXTURE_PATH)

func _init(position: Vector2, main: Node).(position, main, TEXTURE) -> void:
	pass

func _ready() -> void:
	connect("area_entered", main, "on_key_area_entered")
