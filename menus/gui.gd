extends Control

@onready var level_label = %Level_label
@onready var timer_label = %Timer_label
@onready var deaths_label = %Deaths_label

# Called when the node enters the scene tree for the first time.
func _ready():
	updateLevel()
	PlayerStats.died.connect(updateDeaths)
	updateDeaths(PlayerStats.death_count)


func updateLevel():
	level_label.text = "Level: " + str(LevelMap.current_level)

func updateDeaths(deaths):
	deaths_label.text = "Deaths: " + str(deaths)
