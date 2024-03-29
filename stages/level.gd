class_name Level
extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	#Restarts the level when the player dies
	player.tree_exiting.connect(playerDied)
	LevelMap.levelUpdate.connect(playerDidNotDied)

func playerDied():
	get_tree().call_deferred("reload_current_scene")

func playerDidNotDied():
	player.disconnect("tree_exiting", playerDied)
