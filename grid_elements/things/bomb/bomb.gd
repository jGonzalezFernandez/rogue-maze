class_name Bomb
extends Thing

signal explosion_requested

const TEXTURE_PATH = ResourcePath.THINGS + "/bomb/bomb.png"
const TEXTURE = preload(TEXTURE_PATH)

const SOUND_PATH = ResourcePath.THINGS + "bomb/explosion.wav"
const SOUND = preload(SOUND_PATH)

const EXPLOSION_LENGTH = 2

var timer: Timer

func _init(position: Vector2, main: Node) -> void:
	super._init(position, main, TEXTURE)

func _ready() -> void:
	super._ready()
	audio_player.stream = SOUND
	
	light.texture_scale = 0.2
	light.enabled = true
	
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout",Callable(self,"on_timer_timeout"))
	timer.start(BOMB_TIMER_DURATION)
	connect("explosion_requested",Callable(main,"on_bomb_explosion_requested"))

func on_timer_timeout() -> void:
	var explosion_positions = [position]
	for dir in ALL_DIRECTIONS:
		for i in range(1, EXPLOSION_LENGTH):
			var target_cell = dir * Maze.TILE_SIZE * i
			cast_ray_to(target_cell)
			if ray.is_colliding():
				break
			else:
				explosion_positions.append(position + target_cell)
	emit_signal("explosion_requested", self, explosion_positions)
