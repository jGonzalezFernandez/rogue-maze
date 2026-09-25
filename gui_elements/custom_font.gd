class_name CustomFont
extends FontVariation

const FONT_DATA_PATH = ResourcePath.GUI_ELEMENTS + "/FFFFORWA.ttf"
const FONT_DATA = preload(FONT_DATA_PATH)

const LARGE_FONT_SIZE = 60
const NORMAL_FONT_SIZE = 16
const SMALL_FONT_SIZE = 8

const EXTRA_SPACING = 4

func _init(font_size: int = NORMAL_FONT_SIZE, spacing_top: int = EXTRA_SPACING, spacing_bottom: int = EXTRA_SPACING) -> void:
	self.base_font = FONT_DATA
	self.size = font_size
	self.spacing_top = spacing_top
	self.spacing_bottom = spacing_bottom
