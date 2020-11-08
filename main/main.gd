extends ColorRect

const TREASURES_PER_LEVEL = 2
const BACKGROUND_COLOR = Color.black
const STARTING_POSITION = Vector2(Maze.MIN_X, Maze.MAX_Y)
const STATUS_BAR_X_OFFSET = 4
const STATUS_BAR_Y_OFFSET = 2
const ENEMY_STATUS_BARS_Y_OFFSET = Maze.MAX_Y + Maze.TILE_SIZE + STATUS_BAR_Y_OFFSET
const DISTANCE_BETWEEN_ENEMY_BARS = 480

var message_screen: MessageScreen
var player: Player
var player_status_bar: StatusBar
var maze: Maze
var stairs: Stairs
var level_number: int
var enemies: Array
var enemy_status_bars: Array
var allies: Array
var treasures: Array
var first_items: Array
var second_items: Array
var events: Array
var edged_weapon: Edgedweapon
var blunt_weapon: BluntWeapon
var shield: Shield
var amulet: Amulet
var boots: Boots
var ring: Ring
var cloak: Cloak

func _ready() -> void:
#	randomize()
	seed(255) # for testing
	
	color = BACKGROUND_COLOR
	rect_size = OS.get_window_size()
	
	message_screen = MessageScreen.new()
	add_child(message_screen)

func on_new_game_button_pressed() -> void:
	message_screen.hide()
	
	player = Player.new(STARTING_POSITION)
	add_child(player)
	
	player_status_bar = StatusBar.new(player)
	player_status_bar.offset = Vector2(STATUS_BAR_X_OFFSET, STATUS_BAR_Y_OFFSET)
	add_child(player_status_bar)
	
	new_level()
	set_enemy_status_bars()
	
	first_items = [StatusBar.Item.SWORD, StatusBar.Item.MACE, StatusBar.Item.WOODEN_SHIELD, StatusBar.Item.AMULET, StatusBar.Item.BOOTS, StatusBar.Item.HEART_CONTAINER]
	second_items = [StatusBar.Item.CHAOS_SWORD, StatusBar.Item.HAMMER, StatusBar.Item.SHIELD, StatusBar.Item.RING, StatusBar.Item.CLOAK]

func add_enemy(enemy: Enemy) -> void:
	add_child(enemy)
	enemies.append(enemy)

func add_ally(ally: Ally) -> void:
	add_child(ally)
	allies.append(ally)

func add_treasure(treasure: Treasure) -> void:
	add_child(treasure)
	treasures.append(treasure)

func add_event(event: Event) -> void:
	add_child(event)
	events.append(event)

func set_char_position(character: Character, position: Vector2) -> void:
	character.tween.remove_all()
	character.position = position

func new_level() -> void:
	level_number += 1
	match level_number:
		1:
			maze = Maze.new(GenerationAlgorithm.BINARY_TREE, true)
			add_enemy(Bear.new(maze.random_position(), player, maze))
		2:
			maze = Maze.new(GenerationAlgorithm.SIDEWINDER, true)
			add_enemy(Crocodile.new(maze.random_position(), player, maze))
			add_enemy(Bat.new(maze.random_position(), player, maze))
		3:
			maze = Maze.new(GenerationAlgorithm.RECURSIVE_BACKTRACKER, true)
			add_enemy(Scorpion.new(maze.random_position(), player, maze))
			add_enemy(Spider.new(maze.random_position(), player, maze))
			add_ally(Unicorn.new(maze.random_position(), player, maze))
		4:
			maze = Maze.new(GenerationAlgorithm.RECURSIVE_DIVISION_WITH_ROOMS)
			add_enemy(SkeletonKnight.new(maze.random_position(), player, maze))
			add_enemy(HumanGhost.new(maze.random_position(), player, maze))
		5:
			maze = Maze.new(GenerationAlgorithm.RECURSIVE_DIVISION)
			add_enemy(SkeletonWizard.new(maze.random_position(), player, maze))
			add_enemy(MonsterGhost.new(maze.random_position(), player, maze))
			add_ally(Fairy.new(maze.random_position(), player, maze))
		6:
			maze = Maze.new(GenerationAlgorithm.RECURSIVE_BACKTRACKER)
			add_enemy(Shadow.new(maze.random_position(), player, maze))
		_:
			maze = Maze.new(GenerationAlgorithm.RECURSIVE_BACKTRACKER)
			add_enemy(EvilTwin.new(maze.random_position(), player, maze))
	add_child(maze)
	
	for i in TREASURES_PER_LEVEL:
		add_treasure(Treasure.new(maze.random_position()))
	
#	add_event(Event.new(maze.random_position()))
	
	stairs = Stairs.new(maze.random_position())
	add_child(stairs)

func set_enemy_status_bars():
	var x_offset = STATUS_BAR_X_OFFSET
	for enemy in enemies:
		var status_bar = StatusBar.new(enemy)
		status_bar.offset = Vector2(x_offset, ENEMY_STATUS_BARS_Y_OFFSET)
		add_child(status_bar)
		enemy_status_bars.append(status_bar)
		x_offset += DISTANCE_BETWEEN_ENEMY_BARS

func remove(instance: Object) -> void:
	if is_instance_valid(instance):
		instance.queue_free()

func clean_array(array: Array) -> void:
	for element in array:
		remove(element)
	array.clear()

func clean(everything: bool = false) -> void:
	remove(stairs)
	clean_array(enemies)
	clean_array(enemy_status_bars)
	if everything:
		clean_array(allies)
		remove(player_status_bar)
		remove(player)
		level_number = 0
		first_items.clear()
		second_items.clear()
	else:
		# We want the allies to follow the Player to the next level, so we don't delete
		# them to continue their treatment later (in the update_allies() function).
		# Here we just need to unlink the nodes while the new maze is being generated
		for ally in allies:
			remove_child(ally)
	clean_array(treasures)
	clean_array(events)
	remove(maze)

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

func stairs_reached(_area) -> void:
	call_deferred("next_level")

func treasure_reached(_area, treasure: Treasure) -> void:
	if !first_items.empty():
		match Utils.pop_random_elem(first_items):
			StatusBar.Item.SWORD:
				edged_weapon = Edgedweapon.new()
				player_status_bar.inventory.add_child(edged_weapon)
				player.slashing_atk += 2
			StatusBar.Item.MACE:
				blunt_weapon = BluntWeapon.new()
				player_status_bar.inventory.add_child(blunt_weapon)
				player.blunt_atk = 2
			StatusBar.Item.WOODEN_SHIELD:
				shield = Shield.new()
				player_status_bar.inventory.add_child(shield)
				player.def += 1
			StatusBar.Item.AMULET:
				amulet = Amulet.new()
				player_status_bar.inventory.add_child(amulet)
				player.def += 1
			StatusBar.Item.BOOTS:
				boots = Boots.new()
				player_status_bar.inventory.add_child(boots)
				player.set_durations(Player.INITIAL_SPEED + 0.5)
				player.dash_ability = true
			StatusBar.Item.HEART_CONTAINER:
				player.max_health += 2
				player_status_bar.heart_bar.add_child(Heart.new())
				player.health += 2
				player_status_bar.set_hearts(player.health)
	elif !second_items.empty():
		match Utils.pop_random_elem(second_items):
			StatusBar.Item.CHAOS_SWORD:
				edged_weapon.texture = Edgedweapon.CHAOS_SWORD
				player.slashing_atk += 2
			StatusBar.Item.HAMMER:
				blunt_weapon.texture = BluntWeapon.HAMMER
				player.blunt_atk += 2
			StatusBar.Item.SHIELD:
				shield.texture = Shield.SHIELD
				player.def += 2
			StatusBar.Item.RING:
				ring = Ring.new()
				player_status_bar.inventory.add_child(ring)
				player.magic_atk += 2
			StatusBar.Item.CLOAK:
				cloak = Cloak.new()
				player_status_bar.inventory.add_child(cloak)
				player.invisible = true
				player.max_alpha = Spectre.MAX_ALPHA
				player.modulate.a = player.max_alpha
	else:
		print("money")
	player_status_bar.stats_label.text = player.get_stats()
	remove(treasure)

func on_health_changed(character: Character, new_health: int) -> void:
	if character.name == Character.PLAYER_NAME:
		player_status_bar.set_hearts(new_health)
	else:
		for status_bar in enemy_status_bars:
			if character == status_bar.character:
				status_bar.set_hearts(new_health)

func on_died(character: Character) -> void:
	if character.name == Character.PLAYER_NAME:
		clean(true)
		message_screen.show_game_over()
	else:
		remove(character)
