class_name Stairs
extends Thing

const PADLOCK_TEXTURE_PATH = ResourcePath.THINGS + "/stairs/padlock.png"
const PADLOCK_TEXTURE = preload(PADLOCK_TEXTURE_PATH)

const STAIRS_TEXTURE_PATH = ResourcePath.THINGS + "/stairs/stairs.png"
const STAIRS_TEXTURE = preload(STAIRS_TEXTURE_PATH)

var unlocked = false

func _init(position: Vector2, main: Node).(position, main, PADLOCK_TEXTURE) -> void:
	pass

func _ready() -> void:
	connect("area_entered", main, "on_stairs_area_entered")
	connect("area_exited", main, "on_stairs_area_exited")

func unlock() -> void:
	unlocked = true
	sprite.texture = STAIRS_TEXTURE
