class_name CustomFont
extends DynamicFont

const FONT_DATA_PATH = ResourcePath.GUI_ELEMENTS + "/FFFFORWA.ttf"
const FONT_DATA = preload(FONT_DATA_PATH)

const LARGE_FONT_SIZE = 24
const NORMAL_FONT_SIZE = 16
const SMALL_FONT_SIZE = 8

func _init(font_size: int = NORMAL_FONT_SIZE) -> void:
	font_data = FONT_DATA
	size = font_size
