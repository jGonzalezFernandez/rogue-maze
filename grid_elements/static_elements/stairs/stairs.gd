class_name Stairs
extends StaticElement

const PADLOCK_TEXTURE_PATH = ResourcePath.STATIC_ELEMENTS + "/stairs/padlock.png"
const PADLOCK_TEXTURE = preload(PADLOCK_TEXTURE_PATH)

const STAIRS_TEXTURE_PATH = ResourcePath.STATIC_ELEMENTS + "/stairs/stairs.png"
const STAIRS_TEXTURE = preload(STAIRS_TEXTURE_PATH)

var unlocked = false

func _init(position: Vector2).(PADLOCK_TEXTURE, position) -> void:
	pass

func _ready() -> void:
	connect("area_entered", get_parent(), "stairs_reached")

func unlock() -> void:
	unlocked = true
	sprite.texture = STAIRS_TEXTURE
