extends Node2D

@onready var back_button = $Control/BackButton

var selected_button = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	back_button.button_up.connect(func():
		get_tree().call_deferred("change_scene_to_file", LevelMap.main_menu)
		)
	back_button.grab_focus()

		
