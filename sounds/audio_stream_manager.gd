extends Node

#Adapted from https://kidscancode.org/godot_recipes/4.x/audio/audio_manager/index.html

var num_players = 4

var available = []	#Available players
var queue = []		#Queue of sounds to play
var bgmPlayer

var volume = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	#Creates pool of AudioStreamPlayer nodes
	for i in num_players:
		var p = AudioStreamPlayer2D.new()
		add_child(p)
		available.append(p)
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = "SFX"
	bgmPlayer = AudioStreamPlayer2D.new()
	add_child(bgmPlayer)
	bgmPlayer.bus = "Music"
	bgmPlayer.stream = load("res://sounds/music.ogg")

func _on_stream_finished(stream):
	available.append(stream)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()

func play(sound_path):
	queue.append(sound_path)
