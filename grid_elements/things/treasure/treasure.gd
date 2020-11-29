class_name Treasure
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/treasure/treasure.png"
const TEXTURE = preload(TEXTURE_PATH)

func _init(position: Vector2).(TEXTURE, position) -> void:
	pass

func _ready() -> void:
	connect("area_entered", get_parent(), "on_treasure_area_entered", [self])
