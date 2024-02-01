extends Node2D

@onready var volume_bar = $VBoxContainer/VolumeHBoxContainer/VolumeBar

# Called when the node enters the scene tree for the first time.
func _ready():
	volume_bar.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if get_viewport().gui_get_focus_owner() == null:
		#volume_bar.grab_focus()
