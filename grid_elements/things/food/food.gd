class_name Food
extends Thing

const SOUND_PATH = ResourcePath.THINGS + "food/bite.wav"
const SOUND = preload(SOUND_PATH)

var health_refill: int  

func _init(position: Vector2, main: Node, texture: Texture, health_refill: int) -> void:
	super._init(position, main, texture)
	self.health_refill = health_refill

func _ready() -> void:
	super._ready()
	audio_player.stream = SOUND
	connect("area_entered",Callable(main,"on_food_area_entered").bind(self))
	connect("area_exited",Callable(main,"on_food_area_exited").bind(self))
