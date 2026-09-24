class_name EventPopup
extends PopupExt

enum EventName {BAD_LEVER, INVISIBLE_CHEST, LOOSE_TILE, BRAZALET, RED_FOUNTAIN, GOOD_LEVER, BLUE_FOUNTAIN, BOOK, PAINTING, SELLER, STATUES}

var event_name: int
var success: bool
var intro_msg: String
var hint: String
var result_msg: String

var player: Player
var menu_popup: MenuPopup
var yes_button: Button
var no_button: Button

func _init(event_name: int, player: Player, menu_popup: MenuPopup, main: ColorRect, success: bool = true, intro_placeholders_content: Array = [], result_placeholders_content: Array = []).(main) -> void:
	self.event_name = event_name
	self.success = success
	
	match [event_name, success]:
		[EventName.BAD_LEVER, _]:
			self.intro_msg = tr("BAD_LEVER_INTRO_MSG")
			self.hint = tr("BAD_LEVER_HINT")
			self.result_msg = tr("BAD_LEVER_RESULT_MSG")
		[EventName.INVISIBLE_CHEST, _]:
			self.intro_msg = tr("INVISIBLE_CHEST_INTRO_MSG")
			self.hint = tr("INVISIBLE_CHEST_HINT")
			self.result_msg = tr("INVISIBLE_CHEST_RESULT_MSG")
		[EventName.LOOSE_TILE, _]:
			self.intro_msg = tr("LOOSE_TILE_INTRO_MSG")
			self.hint = tr("LOOSE_TILE_HINT")
			self.result_msg = tr("LOOSE_TILE_RESULT_MSG")
		[EventName.BRAZALET, _]:
			self.intro_msg = tr("BRAZALET_INTRO_MSG")
			self.hint = tr("BRAZALET_HINT")
			self.result_msg = tr("BRAZALET_RESULT_MSG")
		[EventName.RED_FOUNTAIN, _]:
			self.intro_msg = tr("RED_FOUNTAIN_INTRO_MSG")
			self.hint = tr("RED_FOUNTAIN_HINT")
			self.result_msg = tr("RED_FOUNTAIN_RESULT_MSG")
		[EventName.GOOD_LEVER, _]:
			self.intro_msg = tr("GOOD_LEVER_INTRO_MSG")
			self.hint = tr("GOOD_LEVER_HINT")
			self.result_msg = tr("GOOD_LEVER_RESULT_MSG")
		[EventName.BLUE_FOUNTAIN, _]:
			self.intro_msg = tr("BLUE_FOUNTAIN_INTRO_MSG")
			self.hint = tr("BLUE_FOUNTAIN_HINT")
			self.result_msg = tr("BLUE_FOUNTAIN_RESULT_MSG")
		[EventName.BOOK, _]:
			self.intro_msg = tr("BOOK_INTRO_MSG")
			self.hint = tr("BOOK_HINT")
			self.result_msg = tr("BOOK_RESULT_MSG")
		[EventName.PAINTING, _]:
			self.intro_msg = tr("PAINTING_INTRO_MSG")
			self.hint = tr("PAINTING_HINT")
			self.result_msg = tr("PAINTING_RESULT_MSG")
		[EventName.SELLER, true]:
			self.intro_msg = tr("SELLER_INTRO_MSG % intro_placeholders_content")
			self.hint = tr("SELLER_HINT")
			self.result_msg = tr("SELLER_RESULT_MSG")
		[EventName.SELLER, false]:
			self.intro_msg = tr("SELLER_INTRO_MSG") % intro_placeholders_content
			self.hint = tr("SELLER_HINT")
			self.result_msg = tr("SELLER_RESULT_MSG_ALT")
		[EventName.STATUES, true]:
			self.intro_msg = tr("STATUES_INTRO_MSG")
			self.hint = tr("STATUES_HINT")
			self.result_msg = tr("STATUES_RESULT_MSG")
		[EventName.STATUES, false]:
			self.intro_msg = tr("STATUES_INTRO_MSG")
			self.hint = tr("STATUES_HINT")
			self.result_msg = tr("STATUES_RESULT_MSG_ALT") % result_placeholders_content
	
	self.player = player
	self.menu_popup = menu_popup

func _ready() -> void:
	menu_popup.set_process_input(false)
	get_tree().paused = true
	
	var full_message = intro_msg
	if player.perception > 1:
		full_message += hint
	message.text = full_message
	message.theme = small_font_theme
	
	yes_button = Button.new()
	yes_button.text = "YES_MSG"
	yes_button.theme = normal_font_theme
	
	no_button = Button.new()
	no_button.text = "NO_MSG"
	no_button.theme = normal_font_theme
	
	v_container.add_child(yes_button)
	v_container.add_child(no_button)
	v_container.set_anchors_and_margins_preset(Control.PRESET_CENTER_BOTTOM, 0, MARGIN)
	
	continue_button.hide()
	
	yes_button.connect("pressed", self, "on_yes_button_pressed")
	no_button.connect("pressed", self, "on_no_button_pressed")
	continue_button.connect("pressed", main, "on_event_popup_continue_button_pressed", [self])

func on_yes_button_pressed() -> void:
	yes_button.hide()
	no_button.hide()
	message.text = result_msg
	continue_button.show()
	continue_button.grab_focus()

func resume_game() -> void:
	menu_popup.set_process_input(true)
	get_tree().paused = false

func on_no_button_pressed() -> void:
	resume_game()
	queue_free()
