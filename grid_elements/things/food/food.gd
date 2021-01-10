class_name Food
extends Thing

var health_refill: int  

func _init(texture: Texture, health_refill: int, position: Vector2).(texture, position) -> void:
	self.health_refill = health_refill

func _ready() -> void:
	connect("area_entered", get_parent(), "on_food_area_entered", [self])
	connect("area_exited", get_parent(), "on_food_area_exited", [self])
