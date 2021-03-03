class_name EventPopup
extends PopupExt

enum EventName {BAD_LEVER}

const BAD_LEVER_INTRO_MESSAGE = "You notice a lever on the wall hidden in the shadows.\nIt has a small skull engraved on it.\nDo you move the lever?"
const BAD_LEVER_RESULT_MESSAGE = "It was a trap!\nA secret trapdoor opens in the ceiling and a stone falls on your head.\nYour life is reduced to half a heart."

var event_name: int
var intro_message: String
var result_message: String

var small_font_theme: CustomTheme
var yes_button: Button
var no_button: Button
var continue_button: Button

func _init(event_name: int, main: ColorRect).(main) -> void:
	self.event_name = event_name
	match event_name:
		EventName.BAD_LEVER:
			self.intro_message = BAD_LEVER_INTRO_MESSAGE
			self.result_message = BAD_LEVER_RESULT_MESSAGE
	
	small_font_theme = CustomTheme.new(CustomFont.new(CustomFont.SMALL_FONT_SIZE), main.color)

func _ready() -> void:
	get_tree().paused = true
	
	message.text = intro_message
	message.theme = small_font_theme
	
	yes_button = Button.new()
	yes_button.text = "yes"
	yes_button.theme = custom_theme
	
	no_button = Button.new()
	no_button.text = "no"
	no_button.theme = custom_theme
	
	continue_button = Button.new()
	continue_button.text = "continue"
	continue_button.focus_mode = FOCUS_ALL
	continue_button.theme = custom_theme
	
	v_container.add_child(yes_button)
	v_container.add_child(no_button)
	v_container.add_child(continue_button)
	v_container.set_anchors_and_margins_preset(Control.PRESET_CENTER)
	
	continue_button.hide()
	
	yes_button.connect("pressed", self, "on_yes_button_pressed")
	continue_button.connect("pressed", main, "on_event_popup_continue_button_pressed", [self])

func on_yes_button_pressed() -> void:
	yes_button.hide()
	no_button.hide()
	message.text = result_message
	continue_button.show()
	continue_button.grab_focus()
