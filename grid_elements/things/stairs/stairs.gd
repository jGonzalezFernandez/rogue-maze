class_name Stairs
extends Thing

const PADLOCK_TEXTURE_PATH = ResourcePath.THINGS + "/stairs/padlock.png"
const PADLOCK_TEXTURE = preload(PADLOCK_TEXTURE_PATH)

const STAIRS_TEXTURE_PATH = ResourcePath.THINGS + "/stairs/stairs.png"
const STAIRS_TEXTURE = preload(STAIRS_TEXTURE_PATH)

var unlocked = false

func _init(position: Vector2).(PADLOCK_TEXTURE, position) -> void:
	pass

func _ready() -> void:
	connect("area_entered", get_parent(), "on_stairs_area_entered")
	connect("area_exited", get_parent(), "on_stairs_area_exited")

func unlock() -> void:
	unlocked = true
	sprite.texture = STAIRS_TEXTURE