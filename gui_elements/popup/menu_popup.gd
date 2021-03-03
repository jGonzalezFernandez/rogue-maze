class_name MenuPopup
extends PopupExt

const GAME_NAME = "ROGUE-MAZE"
const PAUSE_MESSAGE = "PAUSE"
const GAME_OVER_MESSAGE = "GAME OVER"

var large_font_theme: CustomTheme
var new_game_button: Button
var exit_button: Button

func _init(main: ColorRect).(main) -> void:
	large_font_theme = CustomTheme.new(CustomFont.new(CustomFont.LARGE_FONT_SIZE), main.color)

func _ready() -> void:
	message.text = GAME_NAME
	message.theme = large_font_theme
	
	new_game_button = Button.new()
	new_game_button.text = "new game"
	new_game_button.theme = custom_theme
	
	exit_button = Button.new()
	exit_button.text = "exit"
	exit_button.theme = custom_theme
	
	v_container.add_child(new_game_button)
	v_container.add_child(exit_button)
	v_container.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	
	new_game_button.connect("pressed", main, "on_new_game_button_pressed")

func _input(_event):
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
