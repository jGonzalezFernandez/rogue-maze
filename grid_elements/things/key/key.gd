class_name Key
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/key/key.png"
const TEXTURE = preload(TEXTURE_PATH)

const SOUND_PATH = ResourcePath.THINGS + "key/key.wav"
const SOUND = preload(SOUND_PATH)

func _init(position: Vector2, main: Node).(position, main, TEXTURE) -> void:
	pass

func _ready() -> void:
	audio_player.stream = SOUND
	connect("area_entered", main, "on_key_area_entered")
