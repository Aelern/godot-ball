extends Control
@onready var level_select_button = $VBoxContainer/LevelSelectButton
@onready var options_button = $VBoxContainer/OptionsButton
@onready var credits_button = $VBoxContainer/CreditsButton
@onready var start_button = $VBoxContainer/StartButton
@onready var exit_button = $VBoxContainer/ExitButton

func _ready():
	start_button.grab_focus()
	level_select_button.button_up.connect(func():
		get_tree().call_deferred("change_scene_to_file",LevelMap.level_select)
		)
	options_button.button_up.connect(func():
		get_tree().call_deferred("change_scene_to_file",LevelMap.options)
		)
	credits_button.button_up.connect(func():
		get_tree().call_deferred("change_scene_to_file",LevelMap.game_complete)
		)
	start_button.button_up.connect(func():
		LevelMap.current_level = 1
		AudioStreamManager.bgmPlayer.play()
		PlayerStats.reset_run_stats()
		get_tree().call_deferred("change_scene_to_file",LevelMap.levels[1])
		)
	exit_button.button_up.connect(func():
		PlayerStats.save_stats()
		get_tree().call_deferred("quit")
		)
