class_name CustomFont
extends FontVariation

const FONT_DATA_PATH = ResourcePath.GUI_ELEMENTS + "/FFFFORWA.ttf"
const FONT_DATA = preload(FONT_DATA_PATH)

const LARGE_FONT_SIZE = 60
const NORMAL_FONT_SIZE = 16
const SMALL_FONT_SIZE = 8

const EXTRA_SPACING = 4

# NOTE: Since Godot 4.0, font sizes are no longer defined in the font itself but are instead defined in the node that uses the font
var font_size: int

func _init(font_size: int = NORMAL_FONT_SIZE, spacing_top: int = EXTRA_SPACING, spacing_bottom: int = EXTRA_SPACING) -> void:
	self.font_size = font_size
	self.base_font = FONT_DATA
	self.spacing_top = spacing_top
	self.spacing_bottom = spacing_bottom
