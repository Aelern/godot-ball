extends Node

const SAVE_PATH = "user://save.cfg"

var total_death_count: int	#Holds the total times the player has ever died
var death_count: int :	#Holds the total times the player has died this play session
		set(value):
			death_count = value
			died.emit(death_count)
var level_times = []	#For each level, holds the players achieved time and their best time
var sfxVolume = 10
var musicVolume = 10

signal died(new_death_count)

func _ready():
	death_count = 0
	load_stats()
	if level_times == []:
		initialize_saved_values()

func reset_run_stats():
	for i in range(len(LevelMap.levels)):
		level_times[i][0] = 999
	death_count = 0
		
func load_stats() -> void:
	var config = ConfigFile.new()
	var error = config.load(SAVE_PATH)
	if error != OK: return
	total_death_count = config.get_value("game", "totalDeaths")
	level_times = config.get_value("game", "levelTimes")
	sfxVolume = config.get_value("game", "sfxVolume")
	musicVolume = config.get_value("game", "musicVolume")

func save_stats() -> void:
	var config = ConfigFile.new()
	config.set_value("game", "totalDeaths", total_death_count)
	config.set_value("game", "levelTimes", level_times)
	config.set_value("game", "sfxVolume", sfxVolume)
	config.set_value("game", "musicVolume", musicVolume)
	config.save(SAVE_PATH)

func initialize_saved_values():
	total_death_count = 0
	for i in range(len(LevelMap.levels)-1):
		level_times.append([0.0, 15.0])	#Sets default record time for every level to 15 seconds
	level_times.append([0.0, 30.0])	#Last level gets a bigger base time
