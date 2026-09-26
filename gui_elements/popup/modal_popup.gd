# A class that attempts to replicate the behavior of Godot 3's Popup, which extended Control instead of Window.
# In short: a floating window that always stays on top and disables user interaction with the content underneath

class_name ModalPopup
extends Control

const MIN_MARGIN = 10
const MARGIN = MIN_MARGIN + 50
const RECT_SIZE_DIVISOR = 1.2
const BUTTON_MIN_WIDTH = 200

var main: ColorRect
var normal_font_theme: CustomTheme
var small_font_theme: CustomTheme
var panel: Panel
var message: Label
var v_container: VBoxContainer
var continue_button: Button

func _init(main: ColorRect) -> void:
	self.main = main
	normal_font_theme = CustomTheme.new(CustomFont.new(), main.color)
	small_font_theme = CustomTheme.new(CustomFont.new(CustomFont.SMALL_FONT_SIZE), main.color)
	size = Vector2(main.size.x / RECT_SIZE_DIVISOR, main.size.y / RECT_SIZE_DIVISOR)
	process_mode = PROCESS_MODE_ALWAYS
	top_level = true
	hide()

func _ready() -> void:
	panel = Panel.new()
	panel.size = size
	panel.theme = normal_font_theme
	add_child(panel)
	
	message = Label.new()
	message.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT, 0, MARGIN)
	message.horizontal_alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_CENTER 
	message.autowrap_mode = TextServer.AutowrapMode.AUTOWRAP_WORD_SMART
	add_child(message)
	
	v_container = VBoxContainer.new()
	add_child(v_container)
	
	continue_button = Button.new()
	continue_button.text = "CONTINUE_MSG"
	continue_button.focus_mode = Control.FocusMode.FOCUS_ALL
	continue_button.theme = normal_font_theme
	continue_button.custom_minimum_size.x = BUTTON_MIN_WIDTH
	v_container.add_child(continue_button)

# The following functions are intended to faithfully reproduce the C++ implementation of Godot 3's Popup class:
func popup() -> void:
	_do_popup()

func popup_centered() -> void:
	var window_size: Vector2 = get_viewport_rect().size
	var rect: Rect2 = Rect2()
	rect.size = size
	rect.position = ((window_size - rect.size * scale) / 2.0).floor()
	_do_popup(rect, true)

func _do_popup(bounds: Rect2 = Rect2(), centered: bool = false) -> void:
	show()

	if bounds.has_area():
		size = bounds.size
		if centered and bounds.size != size:
			position = bounds.position - ((size - bounds.size) / 2.0).floor()
		else:
			position = bounds.position

	_fix_size()

	var focusable: Control = find_next_valid_focus()
	if focusable:
		focusable.grab_focus()

func _fix_size() -> void:
	var pos: Vector2 = global_position
	var sz: Vector2 = size * scale
	var window_size: Vector2 = get_viewport_rect().size - get_viewport_transform().get_origin()

	if pos.x + sz.x > window_size.x:
		pos.x = window_size.x - sz.x
	if pos.x < 0:
		pos.x = 0
	if pos.y + sz.y > window_size.y:
		pos.y = window_size.y - sz.y
	if pos.y < 0:
		pos.y = 0

	if pos != position:
		global_position = pos
