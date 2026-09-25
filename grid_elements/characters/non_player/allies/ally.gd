class_name Ally
extends NonPlayer

const SPEED = 4.0
const INITIAL_HEALTH = -1
const FRIENDLY_FIRE = 0
const MAX_ALPHA = 1.0

var teleport_threshold: int
var knows_player = false

func _init(initial_position: Vector2, player, maze: Maze, main: Node, texture: Texture, name: String, perception: int) -> void:
	super._init(initial_position, player, maze, main, texture, name, perception, perception, SPEED, INITIAL_HEALTH, FRIENDLY_FIRE, MAX_ALPHA)
	teleport_threshold = perception + MAX_DASH_LENGTH

func _ready() -> void:
	super._ready()
	connect("area_entered",Callable(self,"on_area_entered"))
	connect("area_exited",Callable(self,"on_area_exited"))

func _process(_delta) -> void:
	super._process(delta)
	if !knows_player and player_is_visible():
		knows_player = true
	if !is_moving and knows_player:
		var path = get_point_path_to(player.position)
		if path.size() > teleport_threshold: # to follow the player while dashing
			teleport_to(player.position)
		elif !player_is_perceptible(path):
			follow_path(path, MovementType.RUN, path.size(), false)

func on_area_entered(area) -> void:
	if area is Player:
		stand_behind()

func on_area_exited(_area) -> void:
	stand_forward()
