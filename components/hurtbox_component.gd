class_name HurtboxComponent
extends Area2D

#Hurtbox component does nothing without a child CollisionShape2D/CollisionPolygon2D
#Hurtbox collision property must given the correct layer to function

signal hurt(hitbox)		#Signal used to determine what happens when damaged
