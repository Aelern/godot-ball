class_name Player
extends CharacterBody2D

@export var acceleration: float = 25.0	#Rate speed increases
@export var deceleration: float = 10.0	#Rate speed increases
@export var speed: int = 350	#Max speed in any direction
@export var boostSpeed: int = 750	#Max speed when boosting

@onready var hurtbox_component = $HurtboxComponent		#Used to kill the player

enum States {MOVE, BOOST}
var state = States.MOVE
var boostDir: Vector2

#Handles movement
func _physics_process(delta):
	if state == States.MOVE:
		move_state()
	if state == States.BOOST:
		boost_state(delta)

func move_state():
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
	if Input.is_action_just_released("boost") and velocity != Vector2.ZERO:
		state = States.BOOST
		boostDir = velocity.normalized()
	move_and_slide()
		
func boost_state(delta):
	velocity = boostDir * boostSpeed
	var collision = move_and_collide(velocity * delta)
	if collision:
		state = States.MOVE
		velocity *= 0.1
	#move_and_slide()
	#if get_slide_collision_count() != 0:
	#	state = States.MOVE
