extends Node2D

@export var next_level: PackedScene		#The level the portal sends you to

@onready var hitbox_component = $HitboxComponent	#The hitbox that is looking for the player's collision

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox_component.hit_hurtbox.connect(change_level)

#Run level completion effects then advance to the next level
func change_level(hurtbox: HurtboxComponent):
	hurtbox.get_parent().queue_free()	
