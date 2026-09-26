class_name Event
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/event/event.png"
const TEXTURE = preload(TEXTURE_PATH)

const SOUND_PATH = ResourcePath.THINGS + "event/event.wav"
const SOUND = preload(SOUND_PATH)

func _init(position: Vector2, main: Node) -> void:
	super._init(position, main, TEXTURE)

func _ready() -> void:
	super._ready()
	process_mode = PROCESS_MODE_ALWAYS
	audio_player.stream = SOUND

	connect("area_entered",Callable(main,"on_event_area_entered").bind(self))
	start_blinking()

func start_blinking() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", max_alpha - modulate.a, 1.0)
	tween.tween_callback(Callable(self,"start_blinking"))
