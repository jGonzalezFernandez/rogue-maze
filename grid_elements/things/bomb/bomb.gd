class_name Bomb
extends Thing

signal explosion_requested

const TEXTURE_PATH = ResourcePath.THINGS + "/bomb/bomb.png"
const TEXTURE = preload(TEXTURE_PATH)

const EXPLOSION_LENGTH = 2

var timer: Timer

func _init(position: Vector2).(TEXTURE, position) -> void:
	pass

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", self, "on_timer_timeout")
	timer.start(BOMB_TIMER_DURATION)
	connect("explosion_requested", get_parent(), "on_bomb_explosion_requested")

func on_timer_timeout() -> void:
	var explosion_positions = []
	for dir in ALL_DIRECTIONS:
		for i in range(EXPLOSION_LENGTH):
			var target_cell = dir * Maze.TILE_SIZE * i
			cast_ray_to(target_cell)
			if ray.is_colliding():
				break
			else:
				explosion_positions.append(position + target_cell)
	emit_signal("explosion_requested", self, explosion_positions)
