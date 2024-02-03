class_name SpawnerComponent
extends Node2D
#Spawner component is used to have objects automatically spawn new objects in the game.
#Use by remotely triggering the spawner_component's spawn function

#Code adapted from a tutorial series by Heartbeast https://www.youtube.com/playlist?list=PL9FzW-m48fn09w6j8NowI_pSBVcsb3V78

@export var scene: PackedScene		#The scene to be spawned

#Instantiates an instance of scene at the given position and as a child of the specified parent
func spawn(position: Vector2 = global_position, parent: Node = get_tree().current_scene) -> Node:
	var spawned_object = scene.instantiate()
	spawned_object.global_position = position
	parent.call_deferred("add_child", spawned_object)
	return spawned_object
