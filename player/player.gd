class_name Player
extends CharacterBody2D

@export var acceleration: float = 25.0	#Rate speed increases
@export var deceleration: float = 10.0	#Rate speed increases
@export var speed: int = 350	#Max speed in any direction

@onready var hurtbox_component = $HurtboxComponent		#Used to kill the player

#Handles movement
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		if direction.x:
			velocity.x = move_toward(velocity.x, speed * direction.x, acceleration)
		else:
			velocity.x = move_toward(velocity.x, 0, deceleration)		
		if direction.y:
			velocity.y = move_toward(velocity.y, speed * direction.y, acceleration)
		else:
			velocity.y = move_toward(velocity.y, 0, deceleration)
	else:	#Technically same function, but with deceleration value
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.y = move_toward(velocity.y, 0, deceleration)

	move_and_slide()
