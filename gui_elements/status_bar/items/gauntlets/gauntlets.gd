class_name Gauntlets
extends Item

const GAUNTLETS_TEXTURE_PATH = ResourcePath.ITEMS + "/gauntlets/gauntlets.png"
const GAUNTLETS_TEXTURE = preload(GAUNTLETS_TEXTURE_PATH)

func _init() -> void:
	super._init(GAUNTLETS_TEXTURE)
