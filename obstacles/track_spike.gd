class_name TrackSpike
extends Spike

@export var speed: float = 5

func _ready():
	assert(get_parent() is PathFollow2D, "Error: TrackSpike not a child of a PathFollow2D")

func _physics_process(delta):
	get_parent().progress += speed
