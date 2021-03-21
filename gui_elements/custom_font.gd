class_name CustomFont
extends DynamicFont

const FONT_DATA_PATH = ResourcePath.GUI_ELEMENTS + "/FFFFORWA.ttf"
const FONT_DATA = preload(FONT_DATA_PATH)

const LARGE_FONT_SIZE = 60
const NORMAL_FONT_SIZE = 16
const SMALL_FONT_SIZE = 8

const EXTRA_SPACING = 4

func _init(font_size: int = NORMAL_FONT_SIZE, extra_spacing_top: int = EXTRA_SPACING, extra_spacing_bottom: int = EXTRA_SPACING) -> void:
	font_data = FONT_DATA
	size = font_size
	self.extra_spacing_top = extra_spacing_top
	self.extra_spacing_bottom = extra_spacing_bottom
