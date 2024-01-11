class_name FragileSpike
extends Spike

var speed: Vector2

func set_speed(setSpeed: Vector2):
	speed = setSpeed

func _physics_process(delta):
	var collision = move_and_collide(speed * delta)
	if collision:
		queue_free()
