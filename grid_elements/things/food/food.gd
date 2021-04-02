class_name Food
extends Thing

const SOUND_PATH = ResourcePath.THINGS + "food/bite.wav"
const SOUND = preload(SOUND_PATH)

var health_refill: int  

func _init(position: Vector2, main: Node, texture: Texture, health_refill: int).(position, main, texture) -> void:
	self.health_refill = health_refill

func _ready() -> void:
	audio_player.stream = SOUND
	connect("area_entered", main, "on_food_area_entered", [self])
	connect("area_exited", main, "on_food_area_exited", [self])
