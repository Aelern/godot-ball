extends Node2D


func _input(event):
	if event.is_action_released("ui_accept"):
		LevelMap.current_level = 1
		get_tree().change_scene_to_file("res://stages/level_1.tscn")