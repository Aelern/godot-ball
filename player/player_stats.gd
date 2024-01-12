extends Node

var total_death_count: int	#Holds the total times the player has ever died
var death_count: int	#Holds the total times the player has died this play session
var level_times = []	#For each level, holds the players achieved time and their best time

func _ready():
	for i in range(20):
		level_times.append([0.0, 15.0])	#Sets default record time for every level to 15 seconds
		
func load_stats():
	pass
	#Get total_death_count
	#for i in range(20):
	#	get level_times[i,1]
