class_name Apple
extends Food

const TEXTURE_PATH = ResourcePath.FOOD + "/apple/apple.png"
const TEXTURE = preload(TEXTURE_PATH)

const HEALTH_REFILL = 2

func _init(position: Vector2, main: Node) -> void:
	super._init(position, main, TEXTURE, HEALTH_REFILL)
