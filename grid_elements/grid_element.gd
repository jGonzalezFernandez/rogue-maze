class_name GridElement # The interactive content of the maze
extends Area2D

# The RayCast node of the Character class points by default to the first layer, which 
# is also used by the Player, the walls, and any other node unless otherwise specified
enum Layer {DEFAULT, NORMAL_ENEMIES, SPECTRES, ALLIES}

var texture: Texture
var half_tile = Utils.rounded_half(Maze.TILE_SIZE)

var sprite: Sprite
var collision_shape: CollisionShape2D
var tween: Tween

func _init(texture: Texture, position: Vector2) -> void:
	self.texture = texture
	self.position = position

func _ready() -> void:
	sprite = Sprite.new()
	# We want each element to be adjusted to the cell size
	sprite.offset = Vector2(half_tile, half_tile)
	sprite.texture = texture
	add_child(sprite)
	
	var rectangle_shape = RectangleShape2D.new()
	rectangle_shape.extents = Vector2(7.50361, 7.37397)
	collision_shape = CollisionShape2D.new()
	collision_shape.position = Vector2(half_tile, half_tile)
	collision_shape.shape = rectangle_shape
	add_child(collision_shape)
	
	tween = Tween.new()
	add_child(tween)

func compute_layers(layers: Array) -> int:
	var result = 0
	for layer in layers:
		result += pow(2, layer)
	return result
