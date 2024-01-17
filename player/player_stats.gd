extends Node

const SAVE_PATH = "res://save.cfg"	#"user://save.cfg"

var total_death_count: int	#Holds the total times the player has ever died
var death_count: int	#Holds the total times the player has died this play session
var level_times = []	#For each level, holds the players achieved time and their best time

func _ready():
	death_count = 0
	load_stats()
	if level_times == []:
		initialize_saved_values()
		
func load_stats() -> void:
	var config = ConfigFile.new()
	var error = config.load(SAVE_PATH)
	if error != OK: return
	total_death_count = config.get_value("game", "totalDeaths")
	level_times = config.get_value("game", "levelTimes")

func save_stats() -> void:
	var config = ConfigFile.new()
	config.set_value("game", "totalDeaths", total_death_count)
	config.set_value("game", "levelTimes", level_times)
	config.save(SAVE_PATH)

func initialize_saved_values():
	total_death_count = 0
	for i in range(len(LevelMap.levels)):
		level_times.append([0.0, 15.0])	#Sets default record time for every level to 15 seconds

