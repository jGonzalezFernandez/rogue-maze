class_name Bracelet
extends Item

const BRACELET_TEXTURE_PATH = ResourcePath.ITEMS + "/bracelet/bracelet.png"
const BRACELET_TEXTURE = preload(BRACELET_TEXTURE_PATH)

func _init() -> void:
	super._init(BRACELET_TEXTURE)
