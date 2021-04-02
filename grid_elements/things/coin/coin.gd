class_name Coin
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/coin/coin.png"
const TEXTURE = preload(TEXTURE_PATH)

const SOUND_PATH = ResourcePath.THINGS + "coin/coin.wav"
const SOUND = preload(SOUND_PATH)

func _init(position: Vector2, main: Node).(position, main, TEXTURE) -> void:
	pass

func _ready() -> void:
	audio_player.stream = SOUND
	connect("area_entered", main, "on_coin_area_entered", [self])
