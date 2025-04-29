class_name PopupButton
extends Button

func _init() -> void:
	# To avoid confusing in the UI the button that has the focus with the button highlighted by the mouse.
	# This will also force us to design a game behaving exactly the same way when playing with a PC and when playing with a controller
	mouse_filter = Control.MOUSE_FILTER_IGNORE 
