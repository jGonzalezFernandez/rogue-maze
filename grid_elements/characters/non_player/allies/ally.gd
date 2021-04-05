class_name Ally
extends NonPlayer

const SPEED = 4.0
const INITIAL_HEALTH = -1
const FRIENDLY_FIRE = 0
const MAX_ALPHA = 1.0

var teleport_threshold: int
var knows_player = false

func _init(initial_position: Vector2, player, maze: Maze, main: Node, texture: Texture, name: String, perception: int) \
.(initial_position, player, maze, main, texture, name, perception, perception, SPEED, INITIAL_HEALTH, FRIENDLY_FIRE, MAX_ALPHA) -> void:
	teleport_threshold = perception + MAX_DASH_LENGTH
	collision_layer = compute_layers([Layer.ALLIES])

func _ready() -> void:
	connect("area_entered", self, "on_area_entered")
	connect("area_exited", self, "on_area_exited")

func _process(_delta):
	if !knows_player and player_is_visible():
		knows_player = true
	if !tween.is_active() and knows_player:
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
