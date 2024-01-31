class_name LevelSelectButton
extends Button

@export var level_number: int

# Called when the node enters the scene tree for the first time.
func _ready():
	#When clicked send you to the correct level
	button_up.connect(func():
		get_tree().call_deferred("change_scene_to_file", LevelMap.levels[level_number])
		LevelMap.current_level = level_number
		)
	#Display best time for the level (Probably needs to be it's own child label)
	if len(PlayerStats.level_times) >= level_number:
		text = " " + str(level_number) + " \n(" + str(PlayerStats.level_times[level_number-1][1]) + ")"
	else:
		disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
