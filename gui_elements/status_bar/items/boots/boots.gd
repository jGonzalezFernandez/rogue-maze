class_name Boots
extends Item

const BOOTS_TEXTURE_PATH = ResourcePath.ITEMS + "/boots/boots.png"
const BOOTS_TEXTURE = preload(BOOTS_TEXTURE_PATH)

func _init() -> void:
	super._init(BOOTS_TEXTURE)
