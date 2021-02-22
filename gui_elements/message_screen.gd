class_name MessageScreen
extends GuiElement

const GAME_NAME = "ROGUE-MAZE"
const GAME_OVER_MESSAGE = "GAME OVER"

var message: Label
var new_game_button: Button
var exit_button: Button
var main_container: VBoxContainer

func _init(background_color: Color).(background_color) -> void:
	pass

func _ready() -> void:
	message = Label.new()
	message.text = GAME_NAME
	message.theme = modified_theme(modified_font(20))
	
	new_game_button = Button.new()
	new_game_button.text = "new game"
	new_game_button.theme = base_theme
	
	exit_button = Button.new()
	exit_button.text = "exit"
	exit_button.theme = base_theme
	
	main_container = VBoxContainer.new()
	main_container.add_child(message)
	main_container.add_child(new_game_button)
	main_container.add_child(exit_button)
	main_container.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	add_child(main_container)
	
	new_game_button.connect("pressed", get_parent(), "on_new_game_button_pressed")

func hide() -> void:
	main_container.hide()

func show_game_over() -> void:
	message.text = GAME_OVER_MESSAGE
	main_container.show()
