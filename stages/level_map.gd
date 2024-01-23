extends Node

var levels = {
	1: "res://stages/level_1.tscn",
	2: "res://stages/level_2.tscn",
	3: "res://stages/level_3.tscn",
	4: "res://stages/level_4.tscn",
	5: "res://stages/level_5.tscn",
	6: "res://stages/level_6.tscn"
}

var current_level = 0
var level_time = 0.0 :
	set(value):
		level_time = value
		timeUpdate.emit(level_time)

signal timeUpdate(new_time)
