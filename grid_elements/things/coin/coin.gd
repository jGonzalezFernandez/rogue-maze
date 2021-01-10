class_name Coin
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/coin/coin.png"
const TEXTURE = preload(TEXTURE_PATH)

func _init(position: Vector2).(TEXTURE, position) -> void:
	pass

func _ready() -> void:
	connect("area_entered", get_parent(), "on_coin_area_entered", [self])
