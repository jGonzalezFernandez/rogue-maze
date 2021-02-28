class_name BombExplosion
extends Thing

const TEXTURE_PATH = ResourcePath.THINGS + "/bomb_explosion/bomb_explosion.png"
const TEXTURE = preload(TEXTURE_PATH)

const EXPLOSION_DURATION = 0.30

var timer: Timer

func _init(position: Vector2, main: Node).(position, main, TEXTURE) -> void:
	collision_mask = compute_layers([Layer.DEFAULT, Layer.CORPOREAL_ENEMIES, Layer.INCORPOREAL_ENEMIES])

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", self, "on_timer_timeout")
	timer.start(EXPLOSION_DURATION)

func on_timer_timeout() -> void:
	queue_free()
