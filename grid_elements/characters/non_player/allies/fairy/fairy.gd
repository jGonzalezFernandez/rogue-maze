class_name Fairy
extends Ally

const TEXTURE_PATH = ResourcePath.ALLIES + "/fairy/fairy.png"
const TEXTURE = preload(TEXTURE_PATH)

const NAME = "Fairy"
const PERCEPTION = 1
const TIME_BETWEEN_HEALINGS = 13.0

var timer: Timer

func _init(initial_position: Vector2, player, maze: Maze, main: Node) -> void:
	super._init(initial_position, player, maze, main, TEXTURE, NAME, PERCEPTION)
	collision_layer = compute_layers([])

func _ready() -> void:
	super._ready()
	light.shadow_enabled = true
	light.enabled = true
	
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout",Callable(self,"on_timer_timeout"))
	timer.start(TIME_BETWEEN_HEALINGS)

func on_timer_timeout() -> void:
	if knows_player:
		player.increase_health_if_possible(1)
