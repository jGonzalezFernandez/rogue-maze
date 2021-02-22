class_name GuiElement
extends CanvasLayer

const FONT_DATA_PATH = ResourcePath.GUI_ELEMENTS + "/FFFFORWA.ttf"
const FONT_DATA = preload(FONT_DATA_PATH)

var background_color: Color
var base_font: DynamicFont
var base_theme: Theme

func _init(background_color: Color) -> void:
	self.background_color = background_color

func _ready() -> void:
	base_font = DynamicFont.new()
	base_font.font_data = FONT_DATA
	var font_color = background_color.inverted()
	
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = background_color
	style_box.border_color = background_color.inverted()
	style_box.set_border_width_all(1)
	
	var style_box_inverted = style_box.duplicate()
	style_box_inverted.bg_color = style_box.bg_color.inverted()
	style_box_inverted.border_color = style_box.border_color
	
	base_theme = Theme.new()
	base_theme.set_font("font", "Label", base_font)
	base_theme.set_color("font_color", "Label", font_color)
	
	base_theme.set_font("font", "Button", base_font)
	base_theme.set_color("font_color", "Button", font_color)
	base_theme.set_color("font_color_hover", "Button", font_color.inverted())
	base_theme.set_color("font_color_pressed", "Button", font_color.inverted())
	base_theme.set_stylebox("normal", "Button", style_box)
	base_theme.set_stylebox("hover", "Button", style_box_inverted)
	base_theme.set_stylebox("pressed", "Button", style_box_inverted)

func modified_font(new_size: int) -> DynamicFont:
	var modified_font = base_font.duplicate()
	modified_font.size = new_size
	return modified_font

func modified_theme(new_font: DynamicFont) -> Theme:
	var modified_theme = base_theme.duplicate()
	modified_theme.set_font("font", "Label", new_font)
	modified_theme.set_font("font", "Button", new_font)
	return modified_theme
