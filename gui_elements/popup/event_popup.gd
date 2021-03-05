class_name EventPopup
extends PopupExt

enum EventName {BAD_LEVER, LOOSE_TILE, GOOD_LEVER}

const BAD_LEVER_INTRO_MESSAGE = "You notice a lever on the wall hidden in the shadows.\nIt has a small circle engraved on it.\nDo you move the lever?"
const BAD_LEVER_HINT = "\nPERCEPTION: in fact, the circle looks like some kind of skull."
const BAD_LEVER_RESULT_MESSAGE = "It was a trap!\nA secret trapdoor opens in the ceiling and a stone falls on your head.\nYour life is reduced to half a heart."

const LOOSE_TILE_INTRO_MESSAGE = "You notice a loose tile in the corner of the hallway that looks like a switch.\nUnder normal circumstances you would think it's a trap, but it's strange that it's not right in the middle of the path.\nDo you press it?"
const LOOSE_TILE_HINT = "\nPERCEPTION: the floor sounds hollow in this area."
const LOOSE_TILE_RESULT_MESSAGE = "The floor opens and you fall to the next level!\nYour life is reduced to half a heart."

const GOOD_LEVER_INTRO_MESSAGE = "You notice a lever on the wall hidden in the shadows.\nIt has a small X engraved on it.\nDo you move the lever?"
const GOOD_LEVER_HINT = "\nPERCEPTION: in fact, the X looks like a crossed fork and knife."
const GOOD_LEVER_RESULT_MESSAGE = "A secret compartment opens in the wall. Under the light of a candelabra, the most wonderful food awaits you. What a delicious surprise!\nYou feel better than ever, and you regain all your life plus an extra heart."

var event_name: int
var intro_message: String
var hint: String
var result_message: String

var player: Player
var menu_popup: MenuPopup
var small_font_theme: CustomTheme
var yes_button: Button
var no_button: Button
var continue_button: Button

func _init(event_name: int, player: Player, menu_popup: MenuPopup, main: ColorRect).(main) -> void:
	self.event_name = event_name
	match event_name:
		EventName.BAD_LEVER:
			self.intro_message = BAD_LEVER_INTRO_MESSAGE
			self.hint = BAD_LEVER_HINT
			self.result_message = BAD_LEVER_RESULT_MESSAGE
		EventName.LOOSE_TILE:
			self.intro_message = LOOSE_TILE_INTRO_MESSAGE
			self.hint = LOOSE_TILE_HINT
			self.result_message = LOOSE_TILE_RESULT_MESSAGE
		EventName.GOOD_LEVER:
			self.intro_message = GOOD_LEVER_INTRO_MESSAGE
			self.hint = GOOD_LEVER_HINT
			self.result_message = GOOD_LEVER_RESULT_MESSAGE
	
	self.player = player
	self.menu_popup = menu_popup
	small_font_theme = CustomTheme.new(CustomFont.new(CustomFont.SMALL_FONT_SIZE), main.color)

func _ready() -> void:
	menu_popup.set_process_input(false)
	get_tree().paused = true
	
	var full_message = intro_message
	if player.perception > 0:
		full_message += hint
	message.text = full_message
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
