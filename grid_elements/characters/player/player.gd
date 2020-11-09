class_name Player
extends Character

const TEXTURE_PATH = ResourcePath.CHARACTERS + "/player/player.png"
const TEXTURE = preload(TEXTURE_PATH)

const MOTION_INPUTS = {"ui_up": Vector2.UP, "ui_down": Vector2.DOWN, "ui_right": Vector2.RIGHT, "ui_left": Vector2.LEFT}
const ACTION_INPUT = "ui_accept"

const INITIAL_SPEED = 3.5
const INITIAL_HEALTH = 6
const INITIAL_ALPHA = 1.0
const MAX_DASH_LENGTH = 4

var slashing_atk = 0
var blunt_atk = 1
var magic_atk = 0
var def = 0
var coins = 0
var dash_ability = false
var invisible = false

func _init(initial_position: Vector2).(TEXTURE, PLAYER_NAME, initial_position, INITIAL_SPEED, INITIAL_HEALTH, INITIAL_ALPHA) -> void:
	pass

func _ready() -> void:
	connect("area_entered", self, "on_area_entered")

func _process(_delta) -> void:
	for dir in MOTION_INPUTS.keys():
		if Input.is_action_pressed(dir) and !tween.is_active():
			if dash_ability and Input.is_action_pressed(ACTION_INPUT):
				phasing = true
				for i in range(MAX_DASH_LENGTH, 0, -1):
					if move_tween_if_possible_to(MOTION_INPUTS[dir] * Maze.TILE_SIZE * i, MovementType.RUN, true):
						break
				yield(tween, "tween_all_completed")
				phasing = false
			else:
				move_tween_if_possible_to(MOTION_INPUTS[dir] * Maze.TILE_SIZE, MovementType.RUN)

func get_stats() -> String:
	# We halve the stats displayed in the interface because it's easier to think in terms of whole hearts and half hearts
	return "|  Slashing ATK: %s  |  Blunt ATK: %s  |  Magic ATK: %s  |  DEF: %s  |  Coins: %s  |" % [Utils.half(slashing_atk), Utils.half(blunt_atk), Utils.half(magic_atk), Utils.half(def), coins]

func on_area_entered(area) -> void:
	if area.is_in_group(ENEMY_GROUP):
		manage_collision(area, area.atk - def)
