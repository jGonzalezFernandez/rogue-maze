class_name CustomTheme
extends Theme

func _init(custom_font: CustomFont, background_color: Color) -> void:
	var font_color = background_color.inverted()
	
	set_font("font", "Label", custom_font)
	set_color("font_color", "Label", font_color)
	
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = background_color
	style_box.border_color = background_color.inverted()
	style_box.set_border_width_all(2)
	
	set_stylebox("panel", "Panel", style_box)
	
	var style_box_inverted = style_box.duplicate()
	style_box_inverted.bg_color = style_box.bg_color.inverted()
	style_box_inverted.border_color = style_box.border_color
	
	set_font("font", "Button", custom_font)
	set_color("font_color", "Button", font_color)
	set_color("font_color_hover", "Button", font_color.inverted())
	set_color("font_color_pressed", "Button", font_color.inverted())
	set_stylebox("normal", "Button", style_box)
	set_stylebox("hover", "Button", style_box_inverted)
	set_stylebox("pressed", "Button", style_box_inverted)