extends Node2D



func _input(event):
	if event.is_action_released("ui_accept"):
		get_tree().change_scene_to_file("res://stages/level_1.tscn")
