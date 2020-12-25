class_name Fairy
extends Ally

const TEXTURE_PATH = ResourcePath.ALLIES + "/fairy/fairy.png"
const TEXTURE = preload(TEXTURE_PATH)

const NAME = "Fairy"
const VISION = 1
const HEARING = 1
const SPEED = 3.5
const INITIAL_HEALTH = -1
const TIME_BETWEEN_HEALINGS = 13.0

var timer: Timer

func _init(initial_position: Vector2, player, maze: Maze).(TEXTURE, NAME, initial_position, player, maze, VISION, HEARING, SPEED, INITIAL_HEALTH) -> void:
	pass

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "on_timer_timeout")
	timer.start(TIME_BETWEEN_HEALINGS)

func on_timer_timeout() -> void:
	if knows_player and player.health < player.max_health:
		player.health += 1
		emit_signal("health_changed", player, player.health)
