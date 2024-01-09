class_name BouncingSpike
extends Spike

@export var speed: Vector2 = Vector2.ZERO

func _physics_process(delta):
	var collision = move_and_collide(speed * delta)
	if collision:
		speed = speed.bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())
