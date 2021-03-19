class_name EventPopup
extends PopupExt

enum EventName {BAD_LEVER, LOOSE_TILE, RED_FOUNTAIN, GOOD_LEVER, BLUE_FOUNTAIN, PAINTING, SELLER, STATUES}

const BAD_LEVER_INTRO_MSG = "You notice a lever on the wall hidden in the shadows.\nIt has a small circle engraved on it.\nDo you move the lever?"
const BAD_LEVER_HINT = "\nPERCEPTION: in fact, the circle looks like some kind of skull."
const BAD_LEVER_RESULT_MSG = "It was a trap!\nA secret trapdoor opens in the ceiling and a stone falls on your head.\nYour life is reduced to half a heart."

const LOOSE_TILE_INTRO_MSG = "You notice a loose tile in the corner of the hallway that looks like a switch.\nUnder normal circumstances you would think it's a trap, but it's strange that it's not right in the middle of the path.\nDo you press it?"
const LOOSE_TILE_HINT = "\nPERCEPTION: the floor sounds hollow in this area."
const LOOSE_TILE_RESULT_MSG = "The floor opens and you fall to the next level!\nYour life is reduced to half a heart."

const RED_FOUNTAIN_INTRO_MSG = "You come across a fountain, its water glowing with a faint, unnatural red light.\nAn inscription reads: \"Immerse an object to give it power\".\nDo you give it a try?"
const RED_FOUNTAIN_HINT = "\nPERCEPTION: even in the depths of this dungeon, it seems strange to you that there is no trace of life around a water source."
const RED_FOUNTAIN_RESULT_MSG = "You don't want to risk losing something essential for survival, so you start by dipping your old, but trusty, gauntlets.\nThey're ruined! DEF -0.5"

const GOOD_LEVER_INTRO_MSG = "You notice a lever on the wall hidden in the shadows.\nIt has a small X engraved on it.\nDo you move the lever?"
const GOOD_LEVER_HINT = "\nPERCEPTION: in fact, the X looks like a crossed fork and knife."
const GOOD_LEVER_RESULT_MSG = "A secret compartment opens in the wall. Under the light of a candelabra, the most wonderful food awaits you. What a delicious surprise!\nYou feel better than ever, and you regain all your life plus an extra heart."

const BLUE_FOUNTAIN_INTRO_MSG = "You come across a fountain, its water glowing with a faint, unnatural blue light.\nAn inscription reads: \"Immerse an object to give it power\".\nDo you give it a try?"
const BLUE_FOUNTAIN_HINT = "\nPERCEPTION: silver flowers grow beside the water."
const BLUE_FOUNTAIN_RESULT_MSG = "You don't want to risk losing something essential for survival, so you start by dipping your old, but trusty, gauntlets.\nThey've been enchanted! Magic ATK +0.5\nAfter that, the water loses its shine."

const PAINTING_INTRO_MSG = "You find a dusty cloth that seems to be hiding something human-sized.\nDo you remove it to see what's underneath?"
const PAINTING_HINT = "\nPERCEPTION: you feel an evil aura."
const PAINTING_RESULT_MSG = "After removing the fabric, you discover a picture stand with an old painting of yourself, but no face.\nThis vision deeply disturbs you. Perception -1"

const SELLER_INTRO_MSG = "You meet a small, suspicious-looking humanoid.\nHe says: \"I'll sell you the helmet I found for %s gold coins\".\nHe doesn't seem to be carrying the item with him, but perhaps it is hidden somewhere.\nDo you give him the coins you have?"
const SELLER_HINT = "\nPERCEPTION: you notice that he has looked out of the corner of his eye at some vines."
const SELLER_RESULT_MSG = "The little humanoid takes the money and moves some vines, revealing a hole in the wall, from which he pulls out the helmet.\nAfter giving it to you, he says: \"No refunds!\"."
const SELLER_RESULT_MSG_ALT = "You don't have enough money to make the purchase!"

const STATUES_INTRO_MSG = "You find a room full of statues in grotesque poses.\nThe room, rather large, seems even more so because one of the walls is a mirror.\nAfter examining the sculptures, you realize that each of them is missing an object.\nVoices echo in your head: \"You will never be able to leave this cursed maze, unless you restore the stolen treasures. Give them to us, and we will give you what you seek\".\nDo you trust the voices and put the inventory items you have in place?"
const STATUES_HINT = "\nPERCEPTION: one of the voices sounds familiar and comforting."
const STATUES_RESULT_MSG = "After putting the last of the items in place, you are startled to see that... your reflection has disappeared from the mirror!\nHowever, you soon realize the truth: the mirror is no longer there and what looks like a reflection is a completely identical adjacent room.\nUpon inspecting this new room, you discover a treasure chest hidden behind one of the statues, which contains a gem... but not just any gem!\nYou have found the lost family gemstone! Your twin sister can finally rest in peace.\nPress continue to start a new game."
const STATUES_RESULT_MSG_ALT = "You put the items you have in place, but nothing happens.\nIt seems you are missing %s treasures."

var event_name: int
var success: bool
var intro_msg: String
var hint: String
var result_msg: String

var player: Player
var menu_popup: MenuPopup
var small_font_theme: CustomTheme
var yes_button: Button
var no_button: Button
var continue_button: Button

func _init(event_name: int, player: Player, menu_popup: MenuPopup, main: ColorRect, success: bool = true, intro_placeholders_content: Array = [], result_placeholders_content: Array = []).(main) -> void:
	self.event_name = event_name
	self.success = success
	
	match [event_name, success]:
		[EventName.BAD_LEVER, _]:
			self.intro_msg = BAD_LEVER_INTRO_MSG
			self.hint = BAD_LEVER_HINT
			self.result_msg = BAD_LEVER_RESULT_MSG
		[EventName.LOOSE_TILE, _]:
			self.intro_msg = LOOSE_TILE_INTRO_MSG
			self.hint = LOOSE_TILE_HINT
			self.result_msg = LOOSE_TILE_RESULT_MSG
		[EventName.RED_FOUNTAIN, _]:
			self.intro_msg = RED_FOUNTAIN_INTRO_MSG
			self.hint = RED_FOUNTAIN_HINT
			self.result_msg = RED_FOUNTAIN_RESULT_MSG
		[EventName.GOOD_LEVER, _]:
			self.intro_msg = GOOD_LEVER_INTRO_MSG
			self.hint = GOOD_LEVER_HINT
			self.result_msg = GOOD_LEVER_RESULT_MSG
		[EventName.BLUE_FOUNTAIN, _]:
			self.intro_msg = BLUE_FOUNTAIN_INTRO_MSG
			self.hint = BLUE_FOUNTAIN_HINT
			self.result_msg = BLUE_FOUNTAIN_RESULT_MSG
		[EventName.PAINTING, _]:
			self.intro_msg = PAINTING_INTRO_MSG
			self.hint = PAINTING_HINT
			self.result_msg = PAINTING_RESULT_MSG
		[EventName.SELLER, true]:
			self.intro_msg = SELLER_INTRO_MSG % intro_placeholders_content
			self.hint = SELLER_HINT
			self.result_msg = SELLER_RESULT_MSG
		[EventName.SELLER, false]:
			self.intro_msg = SELLER_INTRO_MSG % intro_placeholders_content
			self.hint = SELLER_HINT
			self.result_msg = SELLER_RESULT_MSG_ALT
		[EventName.STATUES, true]:
			self.intro_msg = STATUES_INTRO_MSG
			self.hint = STATUES_HINT
			self.result_msg = STATUES_RESULT_MSG
		[EventName.STATUES, false]:
			self.intro_msg = STATUES_INTRO_MSG
			self.hint = STATUES_HINT
			self.result_msg = STATUES_RESULT_MSG_ALT % result_placeholders_content
	
	self.player = player
	self.menu_popup = menu_popup
	small_font_theme = CustomTheme.new(CustomFont.new(CustomFont.SMALL_FONT_SIZE), main.color)

func _ready() -> void:
	menu_popup.set_process_input(false)
	get_tree().paused = true
	
	var full_message = intro_msg
	if player.perception > 1:
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
	message.text = result_msg
	continue_button.show()
	continue_button.grab_focus()
