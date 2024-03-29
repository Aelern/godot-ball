class_name SpikeSpawner
extends Node2D

@export var speed: Vector2 = Vector2(100.0, 0.0)
@export var rate: float = 1.0

@onready var timer = $Timer
@onready var spawner_component = $SpawnerComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_spike()
	timer.timeout.connect(spawn_spike)
	timer.wait_time = rate
	timer.start()

func spawn_spike():
	var spawned_spike = spawner_component.spawn()
	spawned_spike.speed = speed
