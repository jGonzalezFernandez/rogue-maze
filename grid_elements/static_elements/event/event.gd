class_name Event
extends StaticElement

const TEXTURE = preload("res://grid_elements/static_elements/event/event.png")

func _init(position: Vector2).(TEXTURE, position) -> void:
	pass

func _ready() -> void:
	connect("area_entered", self, "on_area_entered")
	tween.connect("tween_all_completed", self, "on_tween_all_completed")
	reverse_transparency()

func reverse_transparency() -> void:
	tween.interpolate_property(self, "modulate:a", modulate.a, 1 - modulate.a, 1.0)
	tween.start()

func on_tween_all_completed() -> void:
	reverse_transparency()

func on_area_entered(area) -> void:
	print("event")
