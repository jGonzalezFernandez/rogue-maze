class_name Treasure
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/treasure/treasure.png"
const TEXTURE = preload(TEXTURE_PATH)

const SOUND_PATH = ResourcePath.THINGS + "treasure/treasure.wav"
const SOUND = preload(SOUND_PATH)

func _init(position: Vector2, main: Node).(position, main, TEXTURE) -> void:
	pass

func _ready() -> void:
	audio_player.stream = SOUND
	connect("area_entered", main, "on_treasure_area_entered", [self])
