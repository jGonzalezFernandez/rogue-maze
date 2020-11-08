class_name MessageScreen
extends GuiElement

const GAME_NAME = "ROGUE-MAZE"
const GAME_OVER_MESSAGE = "GAME OVER"

var message: Label
var new_game_button: Button
var exit_button: Button
var main_container: VBoxContainer

func _ready() -> void:
	dynamic_font.size = 20
	
	message = Label.new()
	message.text = GAME_NAME
	message.set("custom_fonts/font", dynamic_font)
	
	new_game_button = Button.new()
	new_game_button.text = "new game"
	new_game_button.set("custom_fonts/font", dynamic_font)
	
	exit_button = Button.new()
	exit_button.text = "exit"
	exit_button.set("custom_fonts/font", dynamic_font)
	
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
