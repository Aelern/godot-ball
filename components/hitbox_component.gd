class_name HitboxComponent
extends Area2D

#Hitbox component does nothing without a child CollisionShape2D/CollisionPolygon2D
#Hitbox collision property must be given the correct mask to function

@export var damaging: bool = true	#If true this hitbox will attempt to destroy colliding hurtboxes

signal hit_hurtbox(hurtbox)		#Signal used to detect when hurtbox has been detected and we want to do something to it that is not damage

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(check_collision)

# Process any detected collisions
func check_collision(area: Area2D) -> void:
	if not area is HurtboxComponent:	#Ignore any collisions that aren't with our dedicated hurtboxes
		return
	if damaging:						#Run the damage signal for collisions that are meant to deal damage
		area.hurt.emit(self)
	hit_hurtbox.emit(area)		#Fire the hit_hurtbox signal to activate non-damaging collision effects
