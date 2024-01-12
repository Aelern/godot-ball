class_name TrackSpike
extends Spike

@export var speed: float = 5	#Speed spike moves along the track

#Track Spike must be a child of a PathFollow2D to work (Which should be the child of a Path2D that defines the track
func _ready():
	assert(get_parent() is PathFollow2D, "Error: TrackSpike not a child of a PathFollow2D")

func _physics_process(delta):
	get_parent().progress += speed
