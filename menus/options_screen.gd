extends Node2D

@onready var music_bar = $VBoxContainer/MusicHBoxContainer/MusicBar
@onready var sfx_bar = $VBoxContainer/SFXHBoxContainer/SFXBar

# Called when the node enters the scene tree for the first time.
func _ready():
	sfx_bar.grab_focus()
	#Code adapted from https://www.gdquest.com/tutorial/godot/audio/volume-slider/
	music_bar.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))) * 10
	music_bar.value_changed.connect(func(value):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value / 10))
		PlayerStats.musicVolume = value
		)
	music_bar.focus_entered.connect(func():
		AudioStreamManager.bgmPlayer.play()
		)
	music_bar.focus_exited.connect(func():
		AudioStreamManager.bgmPlayer.stop()
		)
	music_bar.drag_started.connect(func():
		AudioStreamManager.bgmPlayer.play()
		)
	music_bar.drag_ended.connect(func(_value):
		AudioStreamManager.bgmPlayer.stop()
		)
	sfx_bar.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))) * 10
	sfx_bar.value_changed.connect(func(value):
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value / 10))
		AudioStreamManager.play("res://sounds/dash.wav")
		PlayerStats.sfxVolume = value
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if get_viewport().gui_get_focus_owner() == null:
		#volume_bar.grab_focus()
