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
	if PlayerStats.death_count != 0:
		updateDeaths(PlayerStats.death_count)
	else:
		updateDeaths("0")


func updateLevel():
	level_label.text = "Level: " + str(LevelMap.current_level)

func updateDeaths(deaths):
	deaths_label.text = "Deaths: " + str(deaths)

func updateTime(new_time):
	var minutes = int(int(new_time) / 60)
	var seconds = int(new_time) - (60 * minutes)
	var centiseconds = snappedf((new_time - (60 * minutes) - seconds), 0.01) * 100
	if minutes < 10:
		minutes = "0" + str(minutes)
	else:
		minutes = str(minutes)
	if seconds < 10:
		seconds = "0" + str(seconds)
	else:
		seconds = str(seconds)
	if centiseconds < 10:
		centiseconds = "0" + str(centiseconds)
	else:
		centiseconds = str(centiseconds)
	timer_label.text = minutes + ":" + seconds + ":" + centiseconds
