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
		if action == "up":
			InputMap.action_erase_events("ui_up")
			InputMap.action_add_event("ui_up", event)
		elif action == "down":
			InputMap.action_erase_events("ui_down")
			InputMap.action_add_event("ui_down", event)
		elif action == "left":
			InputMap.action_erase_events("ui_left")
			InputMap.action_add_event("ui_left", event)
		elif action == "right":
			InputMap.action_erase_events("ui_right")
			InputMap.action_add_event("ui_right", event)
		elif action == "boost":
			InputMap.action_erase_events("ui_boost")
			InputMap.action_add_event("ui_boost", event)
		button_pressed = false
	
func update_text():
	text = "%s" % InputMap.action_get_events(action)[0].as_text()
