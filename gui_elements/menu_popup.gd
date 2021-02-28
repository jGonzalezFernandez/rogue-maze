class_name MenuPopup
extends Popup

const GAME_NAME = "ROGUE-MAZE"
const PAUSE_MESSAGE = "PAUSE"
const GAME_OVER_MESSAGE = "GAME OVER"

var main: ColorRect
var custom_theme: CustomTheme
var large_font_theme: CustomTheme
var panel: Panel
var message: Label
var new_game_button: Button
var exit_button: Button
var v_container: VBoxContainer

func _init(main: ColorRect) -> void:
	self.main = main
	custom_theme = CustomTheme.new(CustomFont.new(), main.color)
	large_font_theme = CustomTheme.new(CustomFont.new(20), main.color)
	rect_size = Vector2(Utils.half(main.rect_size.x), Utils.half(main.rect_size.y))
	popup_exclusive = true
	pause_mode = PAUSE_MODE_PROCESS

func _ready() -> void:
	panel = Panel.new()
	panel.rect_size = rect_size
	panel.theme = custom_theme
	add_child(panel)
	
	message = Label.new()
	message.text = GAME_NAME
	message.align = Label.ALIGN_CENTER
	message.theme = large_font_theme
	
	new_game_button = Button.new()
	new_game_button.text = "new game"
	new_game_button.theme = custom_theme
	
	exit_button = Button.new()
	exit_button.text = "exit"
	exit_button.theme = custom_theme
	
	v_container = VBoxContainer.new()
	v_container.add_child(message)
	v_container.add_child(new_game_button)
	v_container.add_child(exit_button)
	v_container.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	add_child(v_container)
	
	new_game_button.connect("pressed", main, "on_new_game_button_pressed")

func _input(event):
	if Input.is_action_just_pressed("menu"):
		if get_tree().paused:
			new_game_button.show()
			get_tree().paused = false
			hide()
		elif not visible:
			message.text = PAUSE_MESSAGE
			new_game_button.hide()
			get_tree().paused = true
			popup()

func show_game_over() -> void:
	message.text = GAME_OVER_MESSAGE
	popup()
