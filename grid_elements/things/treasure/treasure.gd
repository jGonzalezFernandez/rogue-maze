class_name Treasure
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/treasure/treasure.png"
const TEXTURE = preload(TEXTURE_PATH)

func _init(position: Vector2, main: Node).(position, main, TEXTURE) -> void:
	pass

func _ready() -> void:
	connect("area_entered", main, "on_treasure_area_entered", [self])
