extends Node2D

@export var rotate_speed: float = 90	#Speed of rotation in degrees per second

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation_degrees += rotate_speed * delta
