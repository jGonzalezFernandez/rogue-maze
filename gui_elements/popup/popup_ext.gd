class_name PopupExt
extends Popup

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
	exclusive = true
	process_mode = PROCESS_MODE_ALWAYS

func _ready() -> void:
	super._ready()
	panel = Panel.new()
	panel.size = size
	panel.theme = normal_font_theme
	add_child(panel)
	
	message = Label.new()
	message.set_anchors_and_offsets_preset(Control.PRESET_WIDE, 0, MARGIN)
	message.align = Label.ALIGNMENT_CENTER
	message.autowrap = true
	add_child(message)
	
	v_container = VBoxContainer.new()
	add_child(v_container)
	
	continue_button = Button.new()
	continue_button.text = "CONTINUE_MSG"
	continue_button.focus_mode = FOCUS_ALL
	continue_button.theme = normal_font_theme
	continue_button.custom_minimum_size.x = BUTTON_MIN_WIDTH
	v_container.add_child(continue_button)
	
