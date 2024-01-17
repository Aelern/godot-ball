extends Node2D

@onready var hitbox_component = $HitboxComponent	#The hitbox that is looking for the player's collision
@onready var level_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox_component.hit_hurtbox.connect(change_level)

func _process(delta):
	level_time += delta

#Run level completion effects then advance to the next level
func change_level(hurtbox: HurtboxComponent):
	if(LevelMap.current_level < len(LevelMap.levels)):
		PlayerStats.level_times[LevelMap.current_level-1][0] = snapped(level_time, 0.01)
		if level_time < PlayerStats.level_times[LevelMap.current_level-1][1]:
			PlayerStats.level_times[LevelMap.current_level-1][1] = snapped(level_time, 0.01)
		get_tree().call_deferred("change_scene_to_file", LevelMap.levels[LevelMap.current_level + 1])
		LevelMap.current_level += 1
	else:
		print("You beat the game I guess")
