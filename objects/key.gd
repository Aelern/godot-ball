class_name Key
extends Node2D

@export var gate: KeyGate
@onready var hitbox_component = $HitboxComponent

func _ready():
	hitbox_component.hit_hurtbox.connect(collected.unbind(1))

func collected():
	gate.queue_free()
	self.queue_free()
