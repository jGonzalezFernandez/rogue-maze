class_name CustomFont
extends DynamicFont

const FONT_DATA_PATH = ResourcePath.GUI_ELEMENTS + "/FFFFORWA.ttf"
const FONT_DATA = preload(FONT_DATA_PATH)

func _init(font_size: int = 16) -> void:
	font_data = FONT_DATA
	size = font_size
