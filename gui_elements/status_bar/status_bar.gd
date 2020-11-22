class_name StatusBar
extends GuiElement

enum Item {SWORD, MACE, WOODEN_SHIELD, CHAINMAIL, BOOTS, AMULET, HEART_CONTAINER, CHAOS_SWORD, HAMMER, SHIELD, RING, CLOAK}

var character: Character
var name_label: Label
var heart_bar: HBoxContainer
var stats_label: Label
var inventory: HBoxContainer
var main_container: HBoxContainer

func _init(character) -> void:
	self.character = character

func _ready() -> void:
	dynamic_font.size = 8
	dynamic_font.extra_spacing_top = 4
	
	name_label = Label.new()
	name_label.text = character.name.to_upper() + "  |" # vertical bar to separate the name from the hearts
	name_label.set("custom_fonts/font", dynamic_font)
	
	heart_bar = HBoxContainer.new()
	for i in Utils.rounded_half(character.max_health):
		heart_bar.add_child(Heart.new())
	set_hearts(character.health)
	
	stats_label = Label.new()
	stats_label.text = character.get_stats()
	stats_label.set("custom_fonts/font", dynamic_font)
	
	inventory = HBoxContainer.new()
	
	main_container = HBoxContainer.new()
	main_container.add_child(name_label)
	main_container.add_child(heart_bar)
	main_container.add_child(stats_label)
	main_container.add_child(inventory)
	main_container.set("custom_constants/separation", 6)
	add_child(main_container)

func set_hearts(health) -> void:
	for i in heart_bar.get_child_count():
		if health > i * 2 + 1:
			heart_bar.get_child(i).texture = Heart.FULL_TEXTURE
		elif health > i * 2:
			heart_bar.get_child(i).texture = Heart.HALF_TEXTURE
		else:
			heart_bar.get_child(i).texture = Heart.EMPTY_TEXTURE
