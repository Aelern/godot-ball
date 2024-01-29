class_name Key
extends Node2D

@export var gate: KeyGate	#The gate the key is connected to. Set manually in scene viewer.
@onready var hitbox_component = $HitboxComponent
@onready var collect_sound = "res://sounds/gateOpen.wav"

func _ready():
	hitbox_component.hit_hurtbox.connect(collected.unbind(1))	

#When the key's hitbox finds the player, destroys both the key and its paired gate
func collected():	
	AudioStreamManager.play(collect_sound)
	gate.queue_free()
	self.queue_free()
