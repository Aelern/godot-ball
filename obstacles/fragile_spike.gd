class_name FragileSpike
extends Spike

@export var speed: Vector2

func _physics_process(delta):
	var collision = move_and_collide(speed * delta)
	if collision:	#Destroys itself if it collides with anything
		queue_free()
