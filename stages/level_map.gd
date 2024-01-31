extends Node

var main_menu = "res://menus/title_screen_1.tscn"

var levels = {
	1: "res://stages/level_1.tscn",
	2: "res://stages/level_2.tscn",
	3: "res://stages/level_3.tscn",
	4: "res://stages/level_4.tscn",
	5: "res://stages/level_5.tscn",
	6: "res://stages/level_6.tscn",
	7: "res://stages/level_7.tscn",
	8: "res://stages/level_8.tscn",
	9: "res://stages/level_9.tscn",
	10: "res://stages/level_10.tscn",
	11: "res://stages/level_11.tscn",
	12: "res://stages/level_12.tscn"
}

var current_level = 0
var level_time = 0.0 :
	set(value):
		level_time = value
		timeUpdate.emit(level_time)

signal timeUpdate(new_time)
