class_name Fairy
extends Ally

const TEXTURE_PATH = ResourcePath.ALLIES + "/fairy/fairy.png"
const TEXTURE = preload(TEXTURE_PATH)
const LIGHT_TEXTURE_PATH = ResourcePath.ALLIES + "/fairy/light.png"
const LIGHT_TEXTURE = preload(LIGHT_TEXTURE_PATH)

const NAME = "Fairy"
const VISION = 1
const HEARING = 1
const SPEED = 3.5
const INITIAL_HEALTH = -1
const TIME_BETWEEN_HEALINGS = 13.0

var light: Light2D
var timer: Timer

func _init(initial_position: Vector2, player, maze: Maze, main: Node) \
.(initial_position, player, maze, main, TEXTURE, NAME, VISION, HEARING, SPEED, INITIAL_HEALTH) -> void:
	pass

func _ready() -> void:
	light = Light2D.new()
	light.position = tile_center
	light.texture = LIGHT_TEXTURE
	light.shadow_enabled = true
	add_child(light)
	
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "on_timer_timeout")
	timer.start(TIME_BETWEEN_HEALINGS)

func on_timer_timeout() -> void:
	if knows_player:
		player.increase_health_if_possible(1)
