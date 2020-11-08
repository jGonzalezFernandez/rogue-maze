class_name GuiElement
extends CanvasLayer

var dynamic_font: DynamicFont

func _ready() -> void:
	dynamic_font = DynamicFont.new()
	dynamic_font.font_data = preload("res://gui_elements/FFFFORWA.ttf")
