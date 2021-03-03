class_name Event
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/event/event.png"
const TEXTURE = preload(TEXTURE_PATH)

func _init(position: Vector2, main: Node).(position, main, TEXTURE) -> void:
	pass

func _ready() -> void:
	connect("area_entered", main, "on_event_area_entered", [self])
	tween.connect("tween_all_completed", self, "on_tween_all_completed")
	reverse_transparency()

func reverse_transparency() -> void:
	tween.interpolate_property(self, "modulate:a", modulate.a, max_alpha - modulate.a, 1.0)
	tween.start()

func on_tween_all_completed() -> void:
	reverse_transparency()
