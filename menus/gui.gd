extends Control

@onready var level_label = %Level_label
@onready var timer_label = %Timer_label
@onready var deaths_label = %Deaths_label

# Called when the node enters the scene tree for the first time.
func _ready():
	updateLevel()
	LevelMap.timeUpdate.connect(updateTime)
	updateTime(0.0)
	PlayerStats.died.connect(updateDeaths)
	updateDeaths(PlayerStats.death_count)


func updateLevel():
	level_label.text = "Level: " + str(LevelMap.current_level)

func updateDeaths(deaths):
	deaths_label.text = "Deaths: " + str(deaths)

func updateTime(new_time):
	var minutes = int(int(new_time) / 60)
	var seconds = int(new_time) - (60 * minutes)
	var centiseconds = snappedf((new_time - (60 * minutes) - seconds), 0.01) * 100
	timer_label.text = str(minutes) + ":" + str(seconds) + ":" + str(centiseconds)
