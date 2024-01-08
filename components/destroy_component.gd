class_name DestroyComponent
extends Node

@export var actor: Node
@export var hurtbox: HurtboxComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	hurtbox.hurt.connect(actor.queue_free.unbind(1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
