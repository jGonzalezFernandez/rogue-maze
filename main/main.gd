extends ColorRect

const STARTING_POSITION = Maze.BOTTOM_LEFT_CORNER
const HELMET_PRICE = 4
const MIN_ITEMS_TO_WIN = 10
const MAX_MINOR_ENEMIES_PER_LEVEL = 9

const BACKGROUND_COLOR = Color.black
const STATUS_BAR_X_OFFSET = 4
const STATUS_BAR_Y_OFFSET = 2
const BOTTOM_Y_OFFSET = 0 - STATUS_BAR_Y_OFFSET
const ENEMY_STATUS_BAR_LAYOUTS = [
	[Control.PRESET_BOTTOM_LEFT, Vector2(STATUS_BAR_X_OFFSET, BOTTOM_Y_OFFSET)],
	[Control.PRESET_BOTTOM_RIGHT, Vector2(0 - STATUS_BAR_X_OFFSET, BOTTOM_Y_OFFSET)],
	[Control.PRESET_CENTER_BOTTOM, Vector2(0, BOTTOM_Y_OFFSET)]]

var canvas_modulate: CanvasModulate
var gui_layer: CanvasLayer
var menu_popup: MenuPopup
var player: Player
var player_status_bar: StatusBar
var maze: Maze
var key: Key
var stairs: Stairs
var level_number: int
var enemies: Array
var enemy_status_bars: Array
var minor_enemies: Array
var allies: Array
var other_elements: Array # treasures, bombs, events...
var first_items: Array
var second_items: Array
var third_items: Array
var edged_weapon: Edgedweapon
var blunt_weapon: BluntWeapon
var shield: Shield
var lens: Lens
var armor: Armor
var boots: Boots
var amulet: Amulet
var ring: Ring
var cloak: Cloak
var bomb_bag: BombBag
var first_events: Array
var second_events: Array
var third_events: Array

func _ready() -> void:
#	randomize()
	seed(255) # for testing
	
	color = BACKGROUND_COLOR
	rect_size = OS.get_window_size()
	
	canvas_modulate = CanvasModulate.new()
	add_child(canvas_modulate)
	
	gui_layer = CanvasLayer.new()
	add_child(gui_layer)
	
	menu_popup = MenuPopup.new(self)
	gui_layer.add_child(menu_popup)
	menu_popup.popup_centered()

func on_new_game_button_pressed(is_new_game_plus: bool = false) -> void:
	canvas_modulate.color = Color.white
	menu_popup.hide()
	
	player = Player.new(STARTING_POSITION, self)
	add_child(player)
	
	player_status_bar = StatusBar.new(player, Control.PRESET_TOP_LEFT, Vector2(STATUS_BAR_X_OFFSET, STATUS_BAR_Y_OFFSET), self)
	gui_layer.add_child(player_status_bar)
	
	player_status_bar.inventory.add_child(Gauntlets.new()) # to visually represent the initial state of the Player
	if is_new_game_plus:
		player_status_bar.inventory.add_child(Gem.new())
	
	new_level()
	set_enemy_status_bars()
	
	first_items = [StatusBar.Item.SWORD, StatusBar.Item.MACE, StatusBar.Item.WOODEN_SHIELD, StatusBar.Item.LENS]
	second_items = [StatusBar.Item.CHAINMAIL, StatusBar.Item.BOOTS, StatusBar.Item.AMULET, StatusBar.Item.HEART_CONTAINER]
	third_items = [StatusBar.Item.CHAOS_SWORD, StatusBar.Item.HAMMER, StatusBar.Item.SHIELD, StatusBar.Item.RING, StatusBar.Item.CLOAK, StatusBar.Item.BOMB_BAG]
	
	first_events = [EventPopup.EventName.BAD_LEVER, EventPopup.EventName.LOOSE_TILE, EventPopup.EventName.RED_FOUNTAIN]
	second_events = [EventPopup.EventName.GOOD_LEVER, EventPopup.EventName.BLUE_FOUNTAIN]
	third_events = [EventPopup.EventName.PAINTING, EventPopup.EventName.SELLER]

func add_enemy(enemy: Enemy) -> void:
	add_child(enemy)
	enemies.append(enemy)

func add_minor_enemy_if_possible(minor_enemy: Enemy) -> void:
	for i in range(minor_enemies.size() - 1, -1, -1):
		if !is_instance_valid(minor_enemies[i]): # this can happen if the object has been deleted, but not its reference
			minor_enemies.remove(i)
	if minor_enemies.size() < MAX_MINOR_ENEMIES_PER_LEVEL:
		add_child(minor_enemy)
		minor_enemies.append(minor_enemy)
	else:
		minor_enemy.queue_free()

func add_ally(ally: Ally) -> void:
	add_child(ally)
	allies.append(ally)

func add_element(element: GridElement) -> void:
	add_child(element)
	other_elements.append(element)

func new_level() -> void:
	level_number += 1
	match level_number:
		1:
			maze = Maze.new(GenerationAlgorithm.BINARY_TREE, true)
			add_enemy(Crocodile.new(maze.random_center_position(), player, maze, self))
			add_enemy(CarnivorousPlant.new(maze.TOP_RIGHT_CORNER, player, maze, self))
			add_element(Apple.new(maze.random_center_right_position(), self))
			add_element(Coin.new(maze.random_center_left_position(), self))
		2:
			maze = Maze.new(GenerationAlgorithm.SIDEWINDER, true)
			add_enemy(Bear.new(maze.random_center_position(), player, maze, self))
			add_enemy(Bat.new(maze.random_top_right_position(), player, maze, self))
			add_element(Event.new(maze.random_center_left_position(), self))
			add_element(Coin.new(maze.random_center_right_position(), self))
		3:
			maze = Maze.new(GenerationAlgorithm.RECURSIVE_BACKTRACKER, true)
			add_enemy(Scorpion.new(maze.random_center_position(), player, maze, self))
			var excluded_positions: Array = []
			for i in 4:
				var web_position = maze.random_center_right_position(excluded_positions)
				excluded_positions.append(web_position)
				add_minor_enemy_if_possible(SpiderWeb.new(web_position, player, maze, self))
			add_enemy(Spider.new(maze.random_center_right_position(excluded_positions), player, maze, self))
			add_ally(Unicorn.new(maze.random_center_left_position(), player, maze, self))
			add_element(Ham.new(maze.random_top_right_position(), self))
		4:
			maze = Maze.new(GenerationAlgorithm.RECURSIVE_DIVISION_WITH_ROOMS)
			add_enemy(SkeletonKnight.new(maze.random_center_position(), player, maze, self))
			add_enemy(HumanGhost.new(maze.random_top_right_position(), player, maze, self))
			add_element(Event.new(maze.random_center_right_position(), self))
			add_element(Coin.new(maze.random_center_left_position(), self))
		5:
			maze = Maze.new(GenerationAlgorithm.RECURSIVE_DIVISION)
			canvas_modulate.color = Color.lightgray
			add_enemy(SkeletonWizard.new(maze.random_center_position(), player, maze, self))
			add_enemy(MonsterGhost.new(maze.random_top_right_position(), player, maze, self))
			add_ally(Fairy.new(maze.random_center_left_position(), player, maze, self))
			add_element(Coin.new(maze.random_center_right_position(), self))
		6:
			maze = Maze.new(GenerationAlgorithm.RECURSIVE_BACKTRACKER)
			canvas_modulate.color = Color.gray
			add_enemy(Shadow.new(maze.random_center_position(), player, maze, self))
			add_element(Event.new(maze.random_top_right_position(), self))
			add_element(Event.new(maze.random_center_left_position(), self))
			add_element(Coin.new(maze.random_center_right_position(), self))
		_:
			maze = Maze.new(GenerationAlgorithm.RECURSIVE_BACKTRACKER)
			canvas_modulate.color = Color(0.1, 0.1, 0.1, 1)
			add_enemy(EvilTwin.new(maze.random_center_position(), player, maze, self))
			add_element(Event.new(maze.random_top_right_position(), self))
	add_child(maze)
	
	add_element(Treasure.new(maze.random_top_center_position(), self))
	add_element(Treasure.new(maze.random_bottom_center_position(), self))
	
	key = Key.new(maze.random_top_left_position(), self)
	add_child(key)
	
	stairs = Stairs.new(maze.random_bottom_right_position(), self)
	add_child(stairs)

func set_enemy_status_bars():
	for i in range(enemies.size()):
		var status_bar = StatusBar.new(enemies[i], ENEMY_STATUS_BAR_LAYOUTS[i][0], ENEMY_STATUS_BAR_LAYOUTS[i][1], self)
		gui_layer.add_child(status_bar)
		enemy_status_bars.append(status_bar)

func remove(instance: Object) -> void:
	if is_instance_valid(instance):
		if instance is GridElement and instance.audio_player.playing:
			instance.disable()
			yield(instance.audio_player, "finished")
		instance.queue_free()

func clean_array(array: Array) -> void:
	for element in array:
		remove(element)
	array.clear()

func clean(everything: bool = false) -> void:
	remove(stairs)
	clean_array(enemies)
	clean_array(enemy_status_bars)
	clean_array(minor_enemies)
	remove(key)
	if everything:
		clean_array(allies)
		remove(player_status_bar)
		remove(player)
		level_number = 0
		first_items.clear()
		second_items.clear()
		third_items.clear()
		first_events.clear()
		second_events.clear()
		third_events.clear()
	else:
		# We want the allies to follow the Player to the next level, so we don't delete
		# them to continue their treatment later (in the update_allies() function).
		# Here we just need to unlink the nodes while the new maze is being generated
		for ally in allies:
			remove_child(ally)
	clean_array(other_elements)
	remove(maze)

func set_char_position(character: Character, position: Vector2) -> void:
	character.tween.remove_all()
	character.modulate.a = character.max_alpha
	character.position = position

func update_allies() -> void:
	for i in range(allies.size() - 1, -1, -1):
		var ally = allies[i]
		if ally.knows_player:
			ally.maze = maze
			set_char_position(ally, STARTING_POSITION)
			add_child(ally)
		elif !is_a_parent_of(ally):
			remove(ally)
			allies.remove(i)

func next_level() -> void:
	clean()
	set_char_position(player, STARTING_POSITION)
	new_level()
	set_enemy_status_bars()
	update_allies()

func on_key_area_entered(_area) -> void:
	stairs.unlock()
	remove(key)

func on_stairs_area_entered(_area) -> void:
	if stairs.unlocked:
		call_deferred("next_level")
	else:
		stairs.stand_behind()

func on_stairs_area_exited(_area) -> void:
	stairs.stand_forward()

func set_player_health(new_health: int) -> void:
	player.health = new_health
	player_status_bar.set_hearts(player.health)

func add_heart_container(new_health: int) -> void:
	player.max_health += 2
	player_status_bar.heart_bar.add_child(Heart.new())
	set_player_health(new_health)

func on_treasure_area_entered(_area, treasure: Treasure) -> void:
	if !first_items.empty():
		match Utils.pop_random_elem(first_items):
			StatusBar.Item.SWORD:
				edged_weapon = Edgedweapon.new()
				player_status_bar.inventory.add_child(edged_weapon)
				player.slashing_atk += 3
			StatusBar.Item.MACE:
				blunt_weapon = BluntWeapon.new()
				player_status_bar.inventory.add_child(blunt_weapon)
				player.blunt_atk = 3
			StatusBar.Item.WOODEN_SHIELD:
				shield = Shield.new()
				player_status_bar.inventory.add_child(shield)
				player.def += 1
			StatusBar.Item.LENS:
				lens = Lens.new()
				player_status_bar.inventory.add_child(lens)
				player.perception += 1
	elif !second_items.empty():
		match Utils.pop_random_elem(second_items):
			StatusBar.Item.CHAINMAIL:
				armor = Armor.new()
				player_status_bar.inventory.add_child(armor)
				player.def += 1
			StatusBar.Item.BOOTS:
				boots = Boots.new()
				player_status_bar.inventory.add_child(boots)
				player.set_durations(Player.INITIAL_SPEED + 0.5)
				player.dash_ability = true
			StatusBar.Item.AMULET:
				amulet = Amulet.new()
				player_status_bar.inventory.add_child(amulet)
				player.teleport_ability = true
			StatusBar.Item.HEART_CONTAINER:
				add_heart_container(player.health + 2)
	elif !third_items.empty():
		match Utils.pop_random_elem(third_items):
			StatusBar.Item.CHAOS_SWORD:
				edged_weapon.texture = Edgedweapon.CHAOS_SWORD_TEXTURE
				player.slashing_atk += 3
			StatusBar.Item.HAMMER:
				blunt_weapon.texture = BluntWeapon.HAMMER_TEXTURE
				player.blunt_atk += 3
			StatusBar.Item.SHIELD:
				shield.texture = Shield.SHIELD_TEXTURE
				player.def += 1
			StatusBar.Item.RING:
				ring = Ring.new()
				player_status_bar.inventory.add_child(ring)
				player.magic_atk += 2
			StatusBar.Item.CLOAK:
				cloak = Cloak.new()
				player_status_bar.inventory.add_child(cloak)
				player.invisible = true
				player.max_alpha = IncorporealEnemy.MAX_ALPHA
				player.modulate.a = player.max_alpha
			StatusBar.Item.BOMB_BAG:
				bomb_bag = BombBag.new()
				player_status_bar.inventory.add_child(bomb_bag)
				player.bomb_ability = true
	else:
		player.coins += HELMET_PRICE
	player_status_bar.stats_label.text = player.get_stats()
	remove(treasure)

func on_coin_area_entered(_area, coin: Coin) -> void:
	player.coins += 1
	player_status_bar.stats_label.text = player.get_stats()
	remove(coin)

func on_player_teleport_requested() -> void:
	if player.position != STARTING_POSITION:
		player.teleport_to(STARTING_POSITION)
		for ally in allies:
			if ally.knows_player:
				ally.teleport_to(STARTING_POSITION)
				yield(ally.tween, "tween_all_completed")
				ally.stand_behind()

func on_player_bomb_requested() -> void:
	add_element(Bomb.new(player.position, self))

func on_bomb_explosion_requested(bomb: Bomb, explosion_positions: Array) -> void:
	remove(bomb)
	for pos in explosion_positions:
		add_element(BombExplosion.new(pos, self))
	for enemy in enemies:
		enemy.run_to_explosion_if_audible(explosion_positions.front())

func _get_enemy_status_bar(character: Character):
	for status_bar in enemy_status_bars:
		if is_instance_valid(status_bar) and character == status_bar.character: # status bar could be null while cleaning
			return status_bar

func on_character_health_changed(character: Character, new_health: int) -> void:
	if character is Player:
		player_status_bar.set_hearts(new_health)
	else:
		var enemy_status_bar_opt = _get_enemy_status_bar(character) # minor enemies have no status bar
		if is_instance_valid(enemy_status_bar_opt):
			enemy_status_bar_opt.set_hearts(new_health)

func on_character_died(character: Character) -> void:
	if character is Player:
		clean(true)
		menu_popup.show_game_over()
	else:
		remove(_get_enemy_status_bar(character))
		remove(character)

func on_food_area_entered(_area, food: Food) -> void:
	if player.increase_health_if_possible(food.health_refill):
		remove(food)
	else:
		food.stand_behind()

func on_food_area_exited(_area, food: Food) -> void:
	food.stand_forward()

func on_event_area_entered(_area, event: Event) -> void:
	var event_popup: EventPopup
	
	if level_number < 4 and !first_events.empty():
		event_popup = EventPopup.new(Utils.pop_random_elem(first_events), player, menu_popup, self)
	elif level_number < 6 and !second_events.empty():
		event_popup = EventPopup.new(Utils.pop_random_elem(second_events), player, menu_popup, self)
	elif level_number == 6 and !third_events.empty():
		match Utils.pop_random_elem(third_events):
			EventPopup.EventName.SELLER:
				if player.coins >= HELMET_PRICE:
					event_popup = EventPopup.new(EventPopup.EventName.SELLER, player, menu_popup, self, true, [player.coins])
				else:
					event_popup = EventPopup.new(EventPopup.EventName.SELLER, player, menu_popup, self, false, [HELMET_PRICE])
			var event_name:
					event_popup = EventPopup.new(event_name, player, menu_popup, self)
	elif level_number > 6:
		var item_count = player_status_bar.inventory.get_child_count()
		event_popup = EventPopup.new(EventPopup.EventName.STATUES, player, menu_popup, self, item_count >= MIN_ITEMS_TO_WIN, [], [MIN_ITEMS_TO_WIN - item_count])
	
	gui_layer.add_child(event_popup)
	event_popup.popup_centered()
	remove(event)

func on_event_popup_continue_button_pressed(event_popup: EventPopup) -> void:
	event_popup.resume_game()
	
	match [event_popup.event_name, event_popup.success]:
		[EventPopup.EventName.BAD_LEVER, _]:
			set_player_health(1)
		[EventPopup.EventName.LOOSE_TILE, _]:
			set_player_health(1)
			call_deferred("next_level")
		[EventPopup.EventName.RED_FOUNTAIN, _]:
			player.def -= 1
			player_status_bar.stats_label.text = player.get_stats()
		[EventPopup.EventName.GOOD_LEVER, _]:
			add_heart_container(player.max_health + 2)
		[EventPopup.EventName.BLUE_FOUNTAIN, _]:
			player.magic_atk += 1
			player_status_bar.stats_label.text = player.get_stats()
		[EventPopup.EventName.PAINTING, _]:
			player.perception -= 1
			player_status_bar.stats_label.text = player.get_stats()
		[EventPopup.EventName.SELLER, true]:
			player.coins = 0
			player_status_bar.inventory.add_child(Helmet.new())
			player.def += 1
			player_status_bar.stats_label.text = player.get_stats()
		[EventPopup.EventName.STATUES, true]:
			clean(true)
			on_new_game_button_pressed(true)
	
	remove(event_popup)
