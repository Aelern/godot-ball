class_name RebindButton
extends Button

#Adapted from https://gamedevartisan.com/tutorials/godot-fundamentals/input-remapping 1/31/24

@export var action: String

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_input(false)
	update_text()

func _toggled(button_pressed):
	set_process_unhandled_input(button_pressed)
	if button_pressed:
		text = "... Awaiting Input ..."
		release_focus()
	else:
		update_text()
		grab_focus()

func _unhandled_input(event):
	if event.pressed:
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, event)
		button_pressed = false
	
func update_text():
	text = "%s" % InputMap.action_get_events(action)[0].as_text()
