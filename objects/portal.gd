extends Node2D

@onready var hitbox_component = $HitboxComponent	#The hitbox that is looking for the player's collision

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox_component.hit_hurtbox.connect(change_level)

#Run level completion effects then advance to the next level
func change_level(hurtbox: HurtboxComponent):
	if(LevelMap.current_level < len(LevelMap.levels)):
		get_tree().call_deferred("change_scene_to_file", LevelMap.levels[LevelMap.current_level + 1])
		LevelMap.current_level += 1
	else:
		print("You beat the game I guess")
