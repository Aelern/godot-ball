extends Node2D

@onready var levels_label = %LevelsLabel
@onready var time_label = %TimeLabel
@onready var best_time_label = %BestTimeLabel
@onready var deaths_label = %DeathsLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in len(LevelMap.levels):
		levels_label.text += str(i+1) + "\n"
		if PlayerStats.level_times[i][0] < 999:
			time_label.text += str(PlayerStats.level_times[i][0]) + "\n"
		else:
			time_label.text += "NA\n"
		best_time_label.text += str(PlayerStats.level_times[i][1]) + "\n"
	deaths_label.text = "Deaths: " + str(PlayerStats.death_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event.is_action_released("boost"):
		get_tree().call_deferred("change_scene_to_file", LevelMap.game_complete)
