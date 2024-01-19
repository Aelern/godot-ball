extends Control

@onready var level_label = %Level_label
@onready var timer_label = %Timer_label
@onready var deaths_label = %Deaths_label

# Called when the node enters the scene tree for the first time.
func _ready():
	updateLevel()


func updateLevel():
	level_label.text = "Level: " + str(LevelMap.current_level)
