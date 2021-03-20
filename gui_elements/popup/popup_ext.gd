class_name PopupExt
extends Popup

const MARGIN = 60
const RECT_SIZE_DIVISOR = 1.2

var main: ColorRect
var custom_theme: CustomTheme
var panel: Panel
var message: Label
var v_container: VBoxContainer
var continue_button: Button

func _init(main: ColorRect) -> void:
	self.main = main
	custom_theme = CustomTheme.new(CustomFont.new(), main.color)
	rect_size = Vector2(main.rect_size.x / RECT_SIZE_DIVISOR, main.rect_size.y / RECT_SIZE_DIVISOR)
	popup_exclusive = true
	pause_mode = PAUSE_MODE_PROCESS

func _ready() -> void:
	panel = Panel.new()
	panel.rect_size = rect_size
	panel.theme = custom_theme
	add_child(panel)
	
	message = Label.new()
	message.set_anchors_and_margins_preset(Control.PRESET_WIDE, 0, MARGIN)
	message.align = Label.ALIGN_CENTER
	message.autowrap = true
	add_child(message)
	
	v_container = VBoxContainer.new()
	add_child(v_container)
	
	continue_button = Button.new()
	continue_button.text = "continue"
	continue_button.focus_mode = FOCUS_ALL
	continue_button.theme = custom_theme
	v_container.add_child(continue_button)
	
