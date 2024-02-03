extends Node2D

@onready var main_menu_button = $VBoxContainer/MainMenuButton

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioStreamManager.bgmPlayer.stop()
	main_menu_button.button_up.connect(func():
		get_tree().call_deferred("change_scene_to_file", LevelMap.main_menu)
		)
	main_menu_button.grab_focus()
	
