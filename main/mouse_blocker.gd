class_name MouseBlocker 
extends Node

# The purpose of this class is to ignore the user's mouse. 
# This will force us to design a game behaving exactly the same way when playing with a PC and when playing with a controller.
# Additionally, not having to worry about the mouse saves us the headache of figuring out how to avoid the confusion between focused and hovered UI buttons.

# For convenience, this node also handles fullscreen mode, where we don’t want the cursor to be visible.

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_pause_mode(PAUSE_MODE_PROCESS) # Allow input processing of this node even when the game is paused (so mouse actions keep being ignored)

func _input(event):
	if event is InputEventMouse:
		get_tree().set_input_as_handled() # So we do nothing except prevent the event from propagating

	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
		get_tree().set_input_as_handled() # To prevent the "Enter" of the "Alt + Enter" combo from triggering the "pressed" signal on UI buttons
