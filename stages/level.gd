class_name Level
extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.tree_exiting.connect(func():
		if get_tree().current_scene != null:
			get_tree().call_deferred("reload_current_scene")
		)
