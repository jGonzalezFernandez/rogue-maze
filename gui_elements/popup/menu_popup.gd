class_name MenuPopup
extends PopupExt

const GAME_NAME = "ROGUE-MAZE"
const GAME_OVER_MESSAGE = "GAME OVER"

const SUPPORTED_LOCALES = ["en", "es", "fr"]

var large_font_theme: CustomTheme
var new_game_button: Button
var language_button: Button
var exit_button: Button
var keybinds_container: VBoxContainer

func _init(main: ColorRect).(main) -> void:
	TranslationServer.set_locale(SUPPORTED_LOCALES[0])
	large_font_theme = CustomTheme.new(CustomFont.new(CustomFont.LARGE_FONT_SIZE), main.color)

func _ready() -> void:
	message.text = GAME_NAME
	message.theme = large_font_theme
	
	new_game_button = Button.new()
	new_game_button.text = "NEW_GAME_BUTTON_MSG"
	new_game_button.theme = normal_font_theme
	new_game_button.rect_min_size.x = BUTTON_MIN_WIDTH

	language_button = Button.new()
	language_button.text = "LANGUAGE_BUTTON_MSG"
	language_button.theme = normal_font_theme
	language_button.rect_min_size.x = BUTTON_MIN_WIDTH
	
	exit_button = Button.new()
	exit_button.text = "EXIT_MSG"
	exit_button.theme = normal_font_theme
	exit_button.rect_min_size.x = BUTTON_MIN_WIDTH
	
	v_container.add_child(new_game_button)
	v_container.add_child(language_button)
	v_container.add_child(exit_button)
	v_container.set_anchors_and_margins_preset(Control.PRESET_CENTER_BOTTOM, 0, MARGIN)
	
	continue_button.hide()
	
	keybinds_container = VBoxContainer.new()
	# add_keybind("UP", "ui_up") too obvious!
	# add_keybind("DOWN", "ui_down")
	# add_keybind("RIGHT", "ui_right")
	# add_keybind("LEFT", "ui_left")
	add_keybind("DASH (requires boots)", "dash")
	add_keybind("TELEPORT TO START (requires amulet)", "teleport")
	add_keybind("PLACE BOMB (requires bomb bag & no movement)", "ui_accept")
	add_child(keybinds_container)
	var allies_desc = Label.new()
	allies_desc.text = "ALLIES: Unicorn blocks enemies, Fairy heals & shines"
	allies_desc.align = Label.ALIGN_RIGHT
	allies_desc.theme = small_font_theme
	keybinds_container.add_child(allies_desc)
	keybinds_container.set_anchors_and_margins_preset(Control.PRESET_BOTTOM_RIGHT, 0, MIN_MARGIN)

	new_game_button.connect("pressed", main, "on_new_game_button_pressed")
	language_button.connect("pressed", self, "on_language_button_pressed")
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
			message.text = "PAUSE_MSG"
			new_game_button.hide()
			continue_button.show()
			get_tree().paused = true
			popup()

func show_game_over() -> void:
	message.text = GAME_OVER_MESSAGE
	popup()

func on_language_button_pressed() -> void:
	var current_index = SUPPORTED_LOCALES.find(TranslationServer.get_locale())
	var new_index = (current_index + 1) % SUPPORTED_LOCALES.size()
	TranslationServer.set_locale(SUPPORTED_LOCALES[new_index])

func on_exit_button_pressed() -> void:
	get_tree().quit()

func on_continue_button_pressed() -> void:
	 hide_and_reset_buttons()

func input_event_to_string(input_event: InputEvent) -> String:
	if input_event is InputEventJoypadButton:
		return Input.get_joy_button_string(input_event.button_index)
	elif input_event is InputEventJoypadMotion:
		return joy_motion_to_string(input_event.axis, input_event.axis_value)
	else:
		return input_event.as_text()

func joy_motion_to_string(axis: int, value: float) -> String:
	match axis:
		JOY_AXIS_0:
			if value > 0:
				return "Joystick Right"
			else:
				return "Joystick Left"
		JOY_AXIS_1:
			if value > 0:
				return "Joystick Down"
			else:
				return "Joystick Up"
		_:
			return "Unsupported Axis" # In this game we'll only use the left stick

func get_keybinds(input_event_action_name: String) -> String:
	var input_events = InputMap.get_action_list(input_event_action_name)
	var keybinds = []
	for ev in input_events:
		keybinds.append(input_event_to_string(ev))
	return PoolStringArray(keybinds).join(", ")

func add_keybind(keybind_desc: String, input_event_action_name: String) -> void:
	var label = Label.new()
	label.text = keybind_desc + ":  " + get_keybinds(input_event_action_name)
	label.align = Label.ALIGN_RIGHT
	label.theme = small_font_theme
	keybinds_container.add_child(label)
