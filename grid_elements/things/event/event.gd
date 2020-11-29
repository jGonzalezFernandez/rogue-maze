class_name Event
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/event/event.png"
const TEXTURE = preload(TEXTURE_PATH)

func _init(position: Vector2).(TEXTURE, position) -> void:
	pass

func _ready() -> void:
	connect("area_entered", self, "on_area_entered")
	tween.connect("tween_all_completed", self, "on_tween_all_completed")
	reverse_transparency()

func reverse_transparency() -> void:
	tween.interpolate_property(self, "modulate:a", modulate.a, max_alpha - modulate.a, 1.0)
	tween.start()

func on_tween_all_completed() -> void:
	reverse_transparency()

func on_area_entered(area) -> void:
	print("event")
