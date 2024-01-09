class_name Player
extends CharacterBody2D

@export var acceleration: float = 50.0	#Rate speed increases
@export var speed: int = 300	#Max speed in any direction

@onready var hurtbox_component = $HurtboxComponent		#Used to kill the player

#Handles movement
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity.x = move_toward(velocity.x, speed * direction.x, acceleration)
		velocity.y = move_toward(velocity.y, speed * direction.y, acceleration)
	else:	#For now these two blocks of code do the same thing. Kept seperate in case I want acceleration and deceleration to be seperate values
		velocity.x = move_toward(velocity.x, 0, acceleration)
		velocity.y = move_toward(velocity.y, 0, acceleration)

	move_and_slide()
