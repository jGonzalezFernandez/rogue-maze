class_name StatusBar
extends HBoxContainer

enum Item {GAUNTLETS, SWORD, MACE, WOODEN_SHIELD, LENS, CHAINMAIL, BOOTS, CLOAK, AMULET, HEART_CONTAINER, CHAOS_SWORD, HAMMER, SHIELD, RING, BOMB_BAG}

var layout_preset: int
var offset: Vector2

var character: Character
var custom_theme: CustomTheme
var name_label: Label
var heart_bar: HBoxContainer
var stats_label: Label
var inventory: HBoxContainer

func _init(character: Character, layout_preset: int, offset: Vector2, main: ColorRect) -> void:
	self.character = character
	self.layout_preset = layout_preset
	self.offset = offset
	
	custom_theme = CustomTheme.new(CustomFont.new(CustomFont.SMALL_FONT_SIZE, CustomFont.EXTRA_SPACING, 0), main.color)
	add_constant_override("separation", 6)

func _ready() -> void:
	name_label = Label.new()
	name_label.text = character.char_name.to_upper() + "  |" # vertical bar to separate the name from the hearts
	name_label.theme = custom_theme
	
	heart_bar = HBoxContainer.new()
	for i in Utils.rounded_half(character.max_health):
		heart_bar.add_child(Heart.new())
	set_hearts(character.health)
	
	stats_label = Label.new()
	stats_label.text = character.get_stats()
	stats_label.theme = custom_theme
	
	inventory = HBoxContainer.new()
	
	add_child(name_label)
	add_child(heart_bar)
	add_child(stats_label)
	add_child(inventory)
	set_anchors_and_margins_preset(layout_preset)
	set_begin(Vector2(margin_left + offset.x, margin_top + offset.y))

func set_hearts(health) -> void:
	for i in heart_bar.get_child_count():
		if health > i * 2 + 1:
			heart_bar.get_child(i).texture = Heart.FULL_TEXTURE
		elif health > i * 2:
			heart_bar.get_child(i).texture = Heart.HALF_TEXTURE
		else:
			heart_bar.get_child(i).texture = Heart.EMPTY_TEXTURE
