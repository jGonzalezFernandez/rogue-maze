class_name Event
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/event/event.png"
const TEXTURE = preload(TEXTURE_PATH)

const SOUND_PATH = ResourcePath.THINGS + "event/event.wav"
const SOUND = preload(SOUND_PATH)

func _init(position: Vector2, main: Node).(position, main, TEXTURE) -> void:
	pass

func _ready() -> void:
	pause_mode = PAUSE_MODE_PROCESS
	audio_player.stream = SOUND

	connect("area_entered", main, "on_event_area_entered", [self])
	start_blinking()

func start_blinking() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", max_alpha - modulate.a, 1.0)
	tween.tween_callback(self, "start_blinking")
