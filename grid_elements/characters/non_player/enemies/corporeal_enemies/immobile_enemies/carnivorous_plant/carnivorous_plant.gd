class_name CarnivorousPlant
extends ImmobileEnemy

const TEXTURE_PATH = ResourcePath.IMMOBILE_ENEMIES + "/carnivorous_plant/carnivorous_plant.png"
const TEXTURE = preload(TEXTURE_PATH)

const NAME = "Carnivorous Plant"
const INITIAL_HEALTH = 4
const ATK = 3
const SLASHING_DEF = 0
const BLUNT_DEF = 0
const FRIENDLY_FIRE = 2

func _init(initial_position: Vector2, player, maze: Maze, main: Node) \
.(initial_position, player, maze, main, TEXTURE, NAME, INITIAL_HEALTH, ATK, SLASHING_DEF, BLUNT_DEF, FRIENDLY_FIRE) -> void:
	pass
