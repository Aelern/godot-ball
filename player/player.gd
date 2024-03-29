class_name Player
extends CharacterBody2D

@export var acceleration: float = 25.0	#Rate speed increases
@export var deceleration: float = 10.0	#Rate speed increases
@export var speed: int = 350	#Max speed in any direction
@export var boostSpeed: int = 750	#Max speed when boosting

@onready var hurtbox_component = $HurtboxComponent		#Used to kill the player
@onready var death_audio = "res://sounds/death.wav"
@onready var dash_audio = "res://sounds/dash.wav"

enum States {MOVE, BOOST}
var state = States.MOVE		#The current movement state
var boostDir: Vector2		#The direction the boost will go in, the players current direction when boost was pressed

func _ready():
	hurtbox_component.hurt.connect(incrementDeathCounters)
	LevelMap.levelUpdate.connect(safely_remove)

func incrementDeathCounters(_area):
	PlayerStats.death_count += 1
	PlayerStats.total_death_count += 1
	AudioStreamManager.play(death_audio)

func safely_remove():
	hurtbox_component.disconnect("hurt", queue_free.unbind(1))
	hurtbox_component.disconnect("hurt", incrementDeathCounters)

#Finite State Machine handles movement for regular movement and the rocket boost
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
	else:	#Same math, but with deceleration value
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.y = move_toward(velocity.y, 0, deceleration)
		
	#Switch to boost state if button pressed
	if Input.is_action_just_released("boost") and velocity != Vector2.ZERO:
		state = States.BOOST
		boostDir = velocity.normalized()
		AudioStreamManager.play(dash_audio)
	move_and_slide()
		
func boost_state(delta):
	velocity = boostDir * boostSpeed
	var collision = move_and_collide(velocity * delta)
	#Switch to move state after hitting something
	if collision:
		state = States.MOVE
		velocity *= 0.1
