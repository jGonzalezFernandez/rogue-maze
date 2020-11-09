class_name GuiElement
extends CanvasLayer

const FONT_DATA_PATH = ResourcePath.GUI_ELEMENTS + "/FFFFORWA.ttf"
const FONT_DATA = preload(FONT_DATA_PATH)

var dynamic_font: DynamicFont

func _ready() -> void:
	dynamic_font = DynamicFont.new()
	dynamic_font.font_data = FONT_DATA
