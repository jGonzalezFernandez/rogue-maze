class_name Ally
extends NonPlayer

const MAX_ALPHA = 1.0

var knows_player = false

func _init(texture: Texture, name: String, initial_position: Vector2, player, maze: Maze, vision: int, hearing: int, speed: float, initial_health: int).(texture, name, initial_position, player, maze, vision, hearing, speed, initial_health, MAX_ALPHA) -> void:
	collision_layer = compute_layers([Layer.ALLIES])

func _ready() -> void:
	connect("area_entered", self, "on_area_entered")
	connect("area_exited", self, "on_area_exited")

func _process(_delta):
	if !knows_player and player_is_visible():
		knows_player = true
	if !tween.is_active() and knows_player:
		var path = get_point_path_to(player.position)
		if path.size() > Utils.rounded_half(maze.COLUMNS): # this could happen when changing levels if something fails...
			position = player.position
		elif !player_is_perceptible(path):
			follow_path(path, MovementType.RUN, path.size(), false)

func on_area_entered(area) -> void:
	if area.name == PLAYER_NAME:
		modulate.a = 0.25

func on_area_exited(_area) -> void:
	modulate.a = max_alpha
