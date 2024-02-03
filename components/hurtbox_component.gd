class_name HurtboxComponent
extends Area2D

#Code adapted from a tutorial series by Heartbeast https://www.youtube.com/playlist?list=PL9FzW-m48fn09w6j8NowI_pSBVcsb3V78

#Hurtbox component does nothing without a child CollisionShape2D/CollisionPolygon2D
#Hurtbox collision property must given the correct layer to function

signal hurt(hitbox)		#Signal used to determine what happens when damaged
