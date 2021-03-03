class_name PopupExt
extends Popup

var main: ColorRect
var custom_theme: CustomTheme
var panel: Panel
var message: Label
var v_container: VBoxContainer

func _init(main: ColorRect) -> void:
	self.main = main
	custom_theme = CustomTheme.new(CustomFont.new(), main.color)
	rect_size = Vector2(Utils.half(main.rect_size.x), Utils.half(main.rect_size.y))
	popup_exclusive = true
	pause_mode = PAUSE_MODE_PROCESS

func _ready() -> void:
	panel = Panel.new()
	panel.rect_size = rect_size
	panel.theme = custom_theme
	add_child(panel)
	
	message = Label.new()
	message.set_anchors_and_margins_preset(Control.PRESET_WIDE, 0, 50)
	message.align = Label.ALIGN_CENTER
	message.autowrap = true
	add_child(message)
	
	v_container = VBoxContainer.new()
	add_child(v_container)
