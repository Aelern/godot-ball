extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	button_up.connect(func():
		get_tree().call_deferred("change_scene_to_file", LevelMap.main_menu)
		)

