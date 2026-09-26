class_name Key
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/key/key.png"
const TEXTURE = preload(TEXTURE_PATH)

const SOUND_PATH = ResourcePath.THINGS + "key/key.wav"
const SOUND = preload(SOUND_PATH)

func _init(position: Vector2, main: Node) -> void:
	super._init(position, main, TEXTURE)

func _ready() -> void:
	super._ready()
	audio_player.stream = SOUND
	connect("area_entered",Callable(main,"on_key_area_entered"))
