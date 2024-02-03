class_name DestroyComponent
extends Node

#Code adapted from a tutorial series by Heartbeast https://www.youtube.com/playlist?list=PL9FzW-m48fn09w6j8NowI_pSBVcsb3V78

@export var actor: Node		#The object that will be destroyed
@export var hurtbox: HurtboxComponent	#The hurtbox that receives the damage (that sends the hurt signal)

# Connect the hurt signal to actor destruction
func _ready():
	hurtbox.hurt.connect(actor.queue_free.unbind(1))
