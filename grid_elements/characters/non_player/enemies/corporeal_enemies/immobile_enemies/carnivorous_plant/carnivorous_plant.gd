class_name CarnivorousPlant
extends ImmobileEnemy

const TEXTURE_PATH = ResourcePath.IMMOBILE_ENEMIES + "/carnivorous_plant/carnivorous_plant.png"
const TEXTURE = preload(TEXTURE_PATH)

const NAME = "Carnivorous Plant"
const INITIAL_HEALTH = 4
const ATK = 3
const FRIENDLY_FIRE = 2
const SLASHING_DEF = 0
const BLUNT_DEF = 0

func _init(initial_position: Vector2, player, maze: Maze).(TEXTURE, NAME, initial_position, player, maze, INITIAL_HEALTH, ATK, FRIENDLY_FIRE, SLASHING_DEF, BLUNT_DEF) -> void:
	pass
