class_name DestroyComponent
extends Node

@export var actor: Node		#The object that will be destroyed
@export var hurtbox: HurtboxComponent	#The hurtbox that receives the damage (that sends the hurt signal)

# Connect the hurt signal to actor destruction
func _ready():
	hurtbox.hurt.connect(actor.queue_free.unbind(1))
