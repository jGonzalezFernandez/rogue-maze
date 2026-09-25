class_name Armor
extends Item

const CHAINMAIL_TEXTURE_PATH = ResourcePath.ITEMS + "/armor/chainmail.png"
const CHAINMAIL_TEXTURE = preload(CHAINMAIL_TEXTURE_PATH)

func _init() -> void:
	super._init(CHAINMAIL_TEXTURE)
