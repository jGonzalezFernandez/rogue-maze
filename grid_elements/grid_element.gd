class_name GridElement # The interactive content of the maze
extends Area2D

# The RayCast node points by default to the first layer, which is also used by
# the Player, the walls, and any other node unless otherwise specified
enum Layer {DEFAULT, CORPOREAL_ENEMIES, INCORPOREAL_ENEMIES, UNICORNS, EXPLOSIONS}

const LIGHT_TEXTURE_PATH = ResourcePath.GRID_ELEMENTS + "/light.png"
const LIGHT_TEXTURE = preload(LIGHT_TEXTURE_PATH)

const BOMB_TIMER_DURATION = 1.5
const ORTHOGONAL_DIRECTIONS = [Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT]
const DIAGONALS = [Vector2(1, -1), Vector2(1, 1), Vector2(-1, 1), Vector2(-1, -1)]
const ALL_DIRECTIONS = ORTHOGONAL_DIRECTIONS + DIAGONALS
const ALPHA_BEHIND = 0.25

var max_alpha: float
var main: Node
var texture: Texture
var sprite: Sprite
var collision_shape: CollisionShape2D
var tween: Tween
var ray: RayCast2D
var audio_player: AudioStreamPlayer2D
var light: Light2D

func _init(position: Vector2, main: Node, texture: Texture, max_alpha: float) -> void:
	self.position = position
	self.main = main
	self.texture = texture
	self.max_alpha = max_alpha
	modulate.a = max_alpha

func _ready() -> void:
	sprite = Sprite.new()
	sprite.texture = texture
	add_child(sprite)
	
	var rectangle_shape = RectangleShape2D.new()
	rectangle_shape.extents = Vector2(7.50361, 7.37397)
	collision_shape = CollisionShape2D.new()
	collision_shape.shape = rectangle_shape
	add_child(collision_shape)
	
	tween = Tween.new()
	add_child(tween)
	
	ray = RayCast2D.new()
	add_child(ray)
	
	audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)
	
	light = Light2D.new()
	light.texture = LIGHT_TEXTURE
	light.mode = Light2D.MODE_MIX
	light.enabled = false # ideally all grid elements should emit a dim light, but this is bad for perf
	add_child(light)

func cast_ray_to(target: Vector2) -> void:
	ray.cast_to = target
	ray.force_raycast_update()

func compute_layers(layers: Array) -> int:
	var result = 0
	for layer in layers:
		result += pow(2, layer)
	return result

func stand_behind() -> void:
	modulate.a = ALPHA_BEHIND

func stand_forward() -> void:
	modulate.a = max_alpha

func disable() -> void:
	collision_shape.set_deferred("disabled", true)
	set_process(false)

func disable_and_hide() -> void:
	disable()
	hide()

func enable() -> void:
	show()
	collision_shape.set_deferred("disabled", false)
	set_process(true)

func fade() -> void:
	disable()
	tween.interpolate_property(self, "scale", scale, Vector2(2.0, 2.0), 0.1)
	tween.interpolate_property(self, "modulate:a", modulate.a, 0, 0.1)
	tween.start()
