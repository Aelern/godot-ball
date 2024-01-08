class_name HitboxComponent
extends Area2D

#If true this hitbox will attempt to destroy colliding hurtboxes
@export var damaging: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(check_collision)

func check_collision(area: Area2D) -> void:
	if not area is HurtboxComponent:
		return
	area.hurt.emit(self)
