class_name MenuPopup
extends PopupExt

const GAME_NAME = "ROGUE-MAZE"
const PAUSE_MESSAGE = "PAUSE"
const GAME_OVER_MESSAGE = "GAME OVER"

var large_font_theme: CustomTheme
var new_game_button: Button
var exit_button: Button
var keybinds_container: VBoxContainer

func _init(main: ColorRect).(main) -> void:
	large_font_theme = CustomTheme.new(CustomFont.new(CustomFont.LARGE_FONT_SIZE), main.color)

func _ready() -> void:
	message.text = GAME_NAME
	message.theme = large_font_theme
	
	new_game_button = Button.new()
	new_game_button.text = "new game"
	new_game_button.theme = normal_font_theme
	
	exit_button = Button.new()
	exit_button.text = "exit"
	exit_button.theme = normal_font_theme
	
	v_container.add_child(new_game_button)
	v_container.add_child(exit_button)
	v_container.set_anchors_and_margins_preset(Control.PRESET_CENTER_BOTTOM, 0, MARGIN)
	
	continue_button.hide()
	
	keybinds_container = VBoxContainer.new()
	add_keybind("UP", "ui_up")
	add_keybind("DOWN", "ui_down")
	add_keybind("RIGHT", "ui_right")
	add_keybind("LEFT", "ui_left")
	add_keybind("DASH (requires boots)", "dash")
	add_keybind("TELEPORT TO START (requires amulet)", "teleport")
	add_keybind("ACCEPT / BOMB (requires bomb bag)", "ui_accept")
	add_child(keybinds_container)
	keybinds_container.set_anchors_and_margins_preset(Control.PRESET_BOTTOM_RIGHT, 0, MIN_MARGIN)
	
	new_game_button.connect("pressed", main, "on_new_game_button_pressed")
	exit_button.connect("pressed", self, "on_exit_button_pressed")
	continue_button.connect("pressed", self, "on_continue_button_pressed")

func hide_and_reset_buttons() -> void:
	hide()
	get_tree().paused = false
	new_game_button.show()
	continue_button.hide()

func _input(_event):
	if Input.is_action_just_pressed("menu"):
		if get_tree().paused:
			 hide_and_reset_buttons()
		elif not visible:
			message.text = PAUSE_MESSAGE
			new_game_button.hide()
			continue_button.show()
			get_tree().paused = true
			popup()

func show_game_over() -> void:
	message.text = GAME_OVER_MESSAGE
	popup()

func on_exit_button_pressed() -> void:
	get_tree().quit()

func on_continue_button_pressed() -> void:
	 hide_and_reset_buttons()

func get_keybinds(input_event_action_name: String) -> String:
	var keybinds = []
	for input_event in InputMap.get_action_list(input_event_action_name):
		if input_event is InputEventKey:
			keybinds.append(input_event.as_text()) # Bug for physical keys here (3.4.4), already fixed in 3.x
		elif input_event is InputEventJoypadButton:
			keybinds.append(Input.get_joy_button_string(input_event.button_index))
	return PoolStringArray(keybinds).join(", ")

func add_keybind(keybind_desc: String, input_event_action_name: String) -> void:
	var label = Label.new()
	label.text = keybind_desc + ":  " + get_keybinds(input_event_action_name)
	label.align = Label.ALIGN_RIGHT
	label.theme = small_font_theme
	keybinds_container.add_child(label)
