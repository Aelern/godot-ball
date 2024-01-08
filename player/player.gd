extends CharacterBody2D

@export var acceleration: float = 50.0
@export var speed: int = 300

#Used to kill the player
@onready var hurtbox_component = $HurtboxComponent

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity.x = move_toward(velocity.x, speed * direction.x, acceleration)
		velocity.y = move_toward(velocity.y, speed * direction.y, acceleration)
		#velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
