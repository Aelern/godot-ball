[1mdiff --git a/assets/Portal.png b/assets/Portal.png[m
[1mnew file mode 100644[m
[1mindex 0000000..40fcce5[m
Binary files /dev/null and b/assets/Portal.png differ
[1mdiff --git a/assets/Portal.png.import b/assets/Portal.png.import[m
[1mnew file mode 100644[m
[1mindex 0000000..d57219b[m
[1m--- /dev/null[m
[1m+++ b/assets/Portal.png.import[m
[36m@@ -0,0 +1,34 @@[m
[32m+[m[32m[remap][m
[32m+[m
[32m+[m[32mimporter="texture"[m
[32m+[m[32mtype="CompressedTexture2D"[m
[32m+[m[32muid="uid://dus1d0aqsanmy"[m
[32m+[m[32mpath="res://.godot/imported/Portal.png-83d786d3c22f5572035bb7cee566baae.ctex"[m
[32m+[m[32mmetadata={[m
[32m+[m[32m"vram_texture": false[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m[deps][m
[32m+[m
[32m+[m[32msource_file="res://assets/Portal.png"[m
[32m+[m[32mdest_files=["res://.godot/imported/Portal.png-83d786d3c22f5572035bb7cee566baae.ctex"][m
[32m+[m
[32m+[m[32m[params][m
[32m+[m
[32m+[m[32mcompress/mode=0[m
[32m+[m[32mcompress/high_quality=false[m
[32m+[m[32mcompress/lossy_quality=0.7[m
[32m+[m[32mcompress/hdr_compression=1[m
[32m+[m[32mcompress/normal_map=0[m
[32m+[m[32mcompress/channel_pack=0[m
[32m+[m[32mmipmaps/generate=false[m
[32m+[m[32mmipmaps/limit=-1[m
[32m+[m[32mroughness/mode=0[m
[32m+[m[32mroughness/src_normal=""[m
[32m+[m[32mprocess/fix_alpha_border=true[m
[32m+[m[32mprocess/premult_alpha=false[m
[32m+[m[32mprocess/normal_map_invert_y=false[m
[32m+[m[32mprocess/hdr_as_srgb=false[m
[32m+[m[32mprocess/hdr_clamp_exposure=false[m
[32m+[m[32mprocess/size_limit=0[m
[32m+[m[32mdetect_3d/compress_to=1[m
[1mdiff --git a/components/destroy_component.gd b/components/destroy_component.gd[m
[1mindex ce821af..f75700a 100644[m
[1m--- a/components/destroy_component.gd[m
[1m+++ b/components/destroy_component.gd[m
[36m@@ -1,14 +1,9 @@[m
 class_name DestroyComponent[m
 extends Node[m
 [m
[31m-@export var actor: Node[m
[31m-@export var hurtbox: HurtboxComponent[m
[32m+[m[32m@export var actor: Node		#The object that will be destroyed[m
[32m+[m[32m@export var hurtbox: HurtboxComponent	#The hurtbox that receives the damage (that sends the hurt signal)[m
 [m
[31m-# Called when the node enters the scene tree for the first time.[m
[32m+[m[32m# Connect the hurt signal to actor destruction[m
 func _ready():[m
 	hurtbox.hurt.connect(actor.queue_free.unbind(1))[m
[31m-[m
[31m-[m
[31m-# Called every frame. 'delta' is the elapsed time since the previous frame.[m
[31m-func _process(delta):[m
[31m-	pass[m
[1mdiff --git a/components/hitbox_component.gd b/components/hitbox_component.gd[m
[1mindex 60fc553..88a128e 100644[m
[1m--- a/components/hitbox_component.gd[m
[1m+++ b/components/hitbox_component.gd[m
[36m@@ -1,15 +1,21 @@[m
 class_name HitboxComponent[m
 extends Area2D[m
 [m
[31m-#If true this hitbox will attempt to destroy colliding hurtboxes[m
[31m-@export var damaging: bool = true[m
[32m+[m[32m#Hitbox component does nothing without a child CollisionShape2D/CollisionPolygon2D[m
[32m+[m[32m#Hitbox collision property must be given the correct mask to function[m
[32m+[m
[32m+[m[32m@export var damaging: bool = true	#If true this hitbox will attempt to destroy colliding hurtboxes[m
[32m+[m
[32m+[m[32msignal hit_hurtbox(hurtbox)		#Signal used to detect when hurtbox has been detected and we want to do something to it that is not damage[m
 [m
 # Called when the node enters the scene tree for the first time.[m
 func _ready():[m
 	area_entered.connect(check_collision)[m
 [m
[32m+[m[32m# Process any detected collisions[m
 func check_collision(area: Area2D) -> void:[m
[31m-	if not area is HurtboxComponent:[m
[32m+[m	[32mif not area is HurtboxComponent:	#Ignore any collisions that aren't with our dedicated hurtboxes[m
 		return[m
[31m-	if damaging:[m
[32m+[m	[32mif damaging:						#Run the damage signal for collisions that are meant to deal damage[m
 		area.hurt.emit(self)[m
[32m+[m	[32mhit_hurtbox.emit(area)		#Fire the hit_hurtbox signal to activate non-damaging collision effects[m
[1mdiff --git a/components/hurtbox_component.gd b/components/hurtbox_component.gd[m
[1mindex 52599d1..705ddfe 100644[m
[1m--- a/components/hurtbox_component.gd[m
[1m+++ b/components/hurtbox_component.gd[m
[36m@@ -1,4 +1,7 @@[m
 class_name HurtboxComponent[m
 extends Area2D[m
 [m
[31m-signal hurt(hitbox)[m
[32m+[m[32m#Hurtbox component does nothing without a child CollisionShape2D/CollisionPolygon2D[m
[32m+[m[32m#Hurtbox collision property must given the correct layer to function[m
[32m+[m
[32m+[m[32msignal hurt(hitbox)		#Signal used to determine what happens when damaged[m
[1mdiff --git a/components/spawner_component.gd b/components/spawner_component.gd[m
[1mnew file mode 100644[m
[1mindex 0000000..02f556f[m
[1m--- /dev/null[m
[1m+++ b/components/spawner_component.gd[m
[36m@@ -0,0 +1,13 @@[m
[32m+[m[32mclass_name SpawnerComponent[m
[32m+[m[32mextends Node2D[m
[32m+[m[32m#Spawner component is used to have objects automatically spawn new objects in the game.[m
[32m+[m[32m#Use by remotely triggering the spawner_component's spawn function[m
[32m+[m
[32m+[m[32m@export var scene: PackedScene		#The scene to be spawned[m
[32m+[m
[32m+[m[32m#Instantiates an instance of scene at the given position and as a child of the specified parent[m
[32m+[m[32mfunc spawn(position: Vector2 = global_position, parent: Node = get_tree().current_scene) -> Node:[m
[32m+[m	[32mvar spawned_object = scene.instantiate()[m
[32m+[m	[32mspawned_object.global_position = position[m
[32m+[m	[32mparent.call_deferred("add_child", spawned_object)[m
[32m+[m	[32mreturn spawned_object[m
[1mdiff --git a/objects/portal.gd b/objects/portal.gd[m
[1mnew file mode 100644[m
[1mindex 0000000..ce024ef[m
[1m--- /dev/null[m
[1m+++ b/objects/portal.gd[m
[36m@@ -0,0 +1,13 @@[m
[32m+[m[32mextends Node2D[m
[32m+[m
[32m+[m[32m@export var next_level: PackedScene		#The level the portal sends you to[m
[32m+[m
[32m+[m[32m@onready var hitbox_component = $HitboxComponent	#The hitbox that is looking for the player's collision[m
[32m+[m
[32m+[m[32m# Called when the node enters the scene tree for the first time.[m
[32m+[m[32mfunc _ready():[m
[32m+[m	[32mhitbox_component.hit_hurtbox.connect(change_level.unbind(1))[m
[32m+[m
[32m+[m[32m#Run level completion effects then advance to the next level[m
[32m+[m[32mfunc change_level():[m
[32m+[m	[32mqueue_free()[m[41m	[m
[1mdiff --git a/objects/portal.tscn b/objects/portal.tscn[m
[1mnew file mode 100644[m
[1mindex 0000000..e2de7d4[m
[1m--- /dev/null[m
[1m+++ b/objects/portal.tscn[m
[36m@@ -0,0 +1,62 @@[m
[32m+[m[32m[gd_scene load_steps=10 format=3 uid="uid://dpauun2i4vpjj"][m
[32m+[m
[32m+[m[32m[ext_resource type="Texture2D" uid="uid://dus1d0aqsanmy" path="res://assets/Portal.png" id="1_pff1u"][m
[32m+[m[32m[ext_resource type="Script" path="res://objects/portal.gd" id="1_usjln"][m
[32m+[m[32m[ext_resource type="Script" path="res://components/hitbox_component.gd" id="2_mehth"][m
[32m+[m
[32m+[m[32m[sub_resource type="AtlasTexture" id="AtlasTexture_lisqa"][m
[32m+[m[32matlas = ExtResource("1_pff1u")[m
[32m+[m[32mregion = Rect2(32, 0, 32, 32)[m
[32m+[m
[32m+[m[32m[sub_resource type="AtlasTexture" id="AtlasTexture_hnu5s"][m
[32m+[m[32matlas = ExtResource("1_pff1u")[m
[32m+[m[32mregion = Rect2(64, 0, 32, 32)[m
[32m+[m
[32m+[m[32m[sub_resource type="AtlasTexture" id="AtlasTexture_ngynl"][m
[32m+[m[32matlas = ExtResource("1_pff1u")[m
[32m+[m[32mregion = Rect2(96, 0, 32, 32)[m
[32m+[m
[32m+[m[32m[sub_resource type="AtlasTexture" id="AtlasTexture_prl5r"][m
[32m+[m[32matlas = ExtResource("1_pff1u")[m
[32m+[m[32mregion = Rect2(0, 0, 32, 32)[m
[32m+[m
[32m+[m[32m[sub_resource type="SpriteFrames" id="SpriteFrames_k3rrb"][m
[32m+[m[32manimations = [{[m
[32m+[m[32m"frames": [{[m
[32m+[m[32m"duration": 1.0,[m
[32m+[m[32m"texture": SubResource("AtlasTexture_lisqa")[m
[32m+[m[32m}, {[m
[32m+[m[32m"duration": 1.0,[m
[32m+[m[32m"texture": SubResource("AtlasTexture_hnu5s")[m
[32m+[m[32m}, {[m
[32m+[m[32m"duration": 1.0,[m
[32m+[m[32m"texture": SubResource("AtlasTexture_ngynl")[m
[32m+[m[32m}, {[m
[32m+[m[32m"duration": 1.0,[m
[32m+[m[32m"texture": SubResource("AtlasTexture_prl5r")[m
[32m+[m[32m}],[m
[32m+[m[32m"loop": true,[m
[32m+[m[32m"name": &"default",[m
[32m+[m[32m"speed": 8.0[m
[32m+[m[32m}][m
[32m+[m
[32m+[m[32m[sub_resource type="CircleShape2D" id="CircleShape2D_v41k1"][m
[32m+[m[32mradius = 32.0[m
[32m+[m
[32m+[m[32m[node name="Portal" type="Node2D"][m
[32m+[m[32mscript = ExtResource("1_usjln")[m
[32m+[m
[32m+[m[32m[node name="AnimatedSprite2D" type="AnimatedSprite2D" parent="."][m
[32m+[m[32mscale = Vector2(2, 2)[m
[32m+[m[32msprite_frames = SubResource("SpriteFrames_k3rrb")[m
[32m+[m[32mautoplay = "default"[m
[32m+[m[32mframe_progress = 0.972423[m
[32m+[m
[32m+[m[32m[node name="HitboxComponent" type="Area2D" parent="."][m
[32m+[m[32mcollision_layer = 0[m
[32m+[m[32mcollision_mask = 2[m
[32m+[m[32mscript = ExtResource("2_mehth")[m
[32m+[m[32mdamaging = false[m
[32m+[m
[32m+[m[32m[node name="CollisionShape2D" type="CollisionShape2D" parent="HitboxComponent"][m
[32m+[m[32mshape = SubResource("CircleShape2D_v41k1")[m
[1mdiff --git a/obstacles/bouncing_spike.gd b/obstacles/bouncing_spike.gd[m
[1mnew file mode 100644[m
[1mindex 0000000..667251b[m
[1m--- /dev/null[m
[1m+++ b/obstacles/bouncing_spike.gd[m
[36m@@ -0,0 +1,10 @@[m
[32m+[m[32mclass_name BouncingSpike[m
[32m+[m[32mextends Spike[m
[32m+[m
[32m+[m[32m@export var speed: Vector2 = Vector2.ZERO[m
[32m+[m
[32m+[m[32mfunc _physics_process(delta):[m
[32m+[m	[32mvar collision = move_and_collide(speed * delta)[m
[32m+[m	[32mif collision:[m
[32m+[m		[32mspeed = speed.bounce(collision.get_normal())[m
[32m+[m		[32mvelocity = velocity.bounce(collision.get_normal())[m
[1mdiff --git a/obstacles/bouncing_spike.tscn b/obstacles/bouncing_spike.tscn[m
[1mnew file mode 100644[m
[1mindex 0000000..a0f27e3[m
[1m--- /dev/null[m
[1m+++ b/obstacles/bouncing_spike.tscn[m
[36m@@ -0,0 +1,8 @@[m
[32m+[m[32m[gd_scene load_steps=3 format=3 uid="uid://wbppobph7c7b"][m
[32m+[m
[32m+[m[32m[ext_resource type="PackedScene" uid="uid://cj00kyspwebpe" path="res://obstacles/spike.tscn" id="1_ccptp"][m
[32m+[m[32m[ext_resource type="Script" path="res://obstacles/bouncing_spike.gd" id="2_bnb7r"][m
[32m+[m
[32m+[m[32m[node name="BouncingSpike" instance=ExtResource("1_ccptp")][m
[32m+[m[32mscript = ExtResource("2_bnb7r")[m
[32m+[m[32mspeed = Vector2(0, 0)[m
[1mdiff --git a/obstacles/spike.gd b/obstacles/spike.gd[m
[1mnew file mode 100644[m
[1mindex 0000000..d6c3be1[m
[1m--- /dev/null[m
[1m+++ b/obstacles/spike.gd[m
[36m@@ -0,0 +1,2 @@[m
[32m+[m[32mclass_name Spike[m
[32m+[m[32mextends CharacterBody2D[m
[1mdiff --git a/obstacles/spike.tscn b/obstacles/spike.tscn[m
[1mindex b2a75f1..cb9adf6 100644[m
[1m--- a/obstacles/spike.tscn[m
[1m+++ b/obstacles/spike.tscn[m
[36m@@ -1,12 +1,18 @@[m
[31m-[gd_scene load_steps=4 format=3 uid="uid://cj00kyspwebpe"][m
[32m+[m[32m[gd_scene load_steps=6 format=3 uid="uid://cj00kyspwebpe"][m
 [m
 [ext_resource type="Texture2D" uid="uid://brkepc3gmb6xf" path="res://assets/Spike.png" id="1_nfrc0"][m
[32m+[m[32m[ext_resource type="Script" path="res://obstacles/spike.gd" id="1_qxf1v"][m
 [ext_resource type="Script" path="res://components/hitbox_component.gd" id="2_4d0uu"][m
 [m
 [sub_resource type="CircleShape2D" id="CircleShape2D_ngh2j"][m
 radius = 12.0[m
 [m
[31m-[node name="Spike" type="Node2D"][m
[32m+[m[32m[sub_resource type="RectangleShape2D" id="RectangleShape2D_cechk"][m
[32m+[m[32msize = Vector2(32, 32)[m
[32m+[m
[32m+[m[32m[node name="Spike" type="CharacterBody2D"][m
[32m+[m[32mcollision_layer = 0[m
[32m+[m[32mscript = ExtResource("1_qxf1v")[m
 [m
 [node name="Sprite2D" type="Sprite2D" parent="."][m
 texture = ExtResource("1_nfrc0")[m
[36m@@ -19,3 +25,7 @@[m [mscript = ExtResource("2_4d0uu")[m
 [node name="CollisionShape2D" type="CollisionShape2D" parent="HitboxComponent"][m
 shape = SubResource("CircleShape2D_ngh2j")[m
 debug_color = Color(0.996078, 0, 0.207843, 0.419608)[m
[32m+[m
[32m+[m[32m[node name="PhysicsCollisionShape2D" type="CollisionShape2D" parent="."][m
[32m+[m[32mshape = SubResource("RectangleShape2D_cechk")[m
[32m+[m[32mdebug_color = Color(1, 1, 1, 0.121569)[m
[1mdiff --git a/player/player.gd b/player/player.gd[m
[1mindex 6a59061..4a95dd4 100644[m
[1m--- a/player/player.gd[m
[1m+++ b/player/player.gd[m
[36m@@ -1,21 +1,19 @@[m
 extends CharacterBody2D[m
 [m
[31m-@export var acceleration: float = 50.0[m
[31m-@export var speed: int = 300[m
[32m+[m[32m@export var acceleration: float = 50.0	#Rate speed increases[m
[32m+[m[32m@export var speed: int = 300	#Max speed in any direction[m
 [m
[31m-#Used to kill the player[m
[31m-@onready var hurtbox_component = $HurtboxComponent[m
[32m+[m[32m@onready var hurtbox_component = $HurtboxComponent		#Used to kill the player[m
 [m
[32m+[m[32m#Handles movement[m
 func _physics_process(delta):[m
 	# Get the input direction and handle the movement/deceleration.[m
[31m-	# As good practice, you should replace UI actions with custom gameplay actions.[m
[31m-	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")[m
[32m+[m	[32mvar direction = Input.get_vector("left", "right", "up", "down")[m
 	if direction:[m
 		velocity.x = move_toward(velocity.x, speed * direction.x, acceleration)[m
 		velocity.y = move_toward(velocity.y, speed * direction.y, acceleration)[m
[31m-		#velocity = direction * speed[m
[31m-	else:[m
[31m-		velocity.x = move_toward(velocity.x, 0, speed)[m
[31m-		velocity.y = move_toward(velocity.y, 0, speed)[m
[32m+[m	[32melse:	#For now these two blocks of code do the same thing. Kept seperate in case I want acceleration and deceleration to be seperate values[m
[32m+[m		[32mvelocity.x = move_toward(velocity.x, 0, acceleration)[m
[32m+[m		[32mvelocity.y = move_toward(velocity.y, 0, acceleration)[m
 [m
 	move_and_slide()[m
[1mdiff --git a/player/player.tscn b/player/player.tscn[m
[1mindex b09c2f6..6c7017f 100644[m
[1m--- a/player/player.tscn[m
[1m+++ b/player/player.tscn[m
[36m@@ -6,16 +6,18 @@[m
 [ext_resource type="Script" path="res://components/destroy_component.gd" id="4_b4t6g"][m
 [m
 [sub_resource type="CircleShape2D" id="CircleShape2D_0ea1r"][m
[31m-radius = 15.0333[m
[32m+[m[32mradius = 16.0[m
 [m
 [sub_resource type="CircleShape2D" id="CircleShape2D_hxe42"][m
 radius = 15.0333[m
 [m
 [node name="Player" type="CharacterBody2D"][m
[32m+[m[32mcollision_layer = 0[m
 script = ExtResource("1_x6vun")[m
 [m
 [node name="PhysicsCollisionShape2D" type="CollisionShape2D" parent="."][m
 shape = SubResource("CircleShape2D_0ea1r")[m
[32m+[m[32mdebug_color = Color(1, 1, 1, 0.270588)[m
 [m
 [node name="Sprite2D" type="Sprite2D" parent="."][m
 texture = ExtResource("1_erqiy")[m
[1mdiff --git a/project.godot b/project.godot[m
[1mindex 9678b02..ba94fc5 100644[m
[1m--- a/project.godot[m
[1m+++ b/project.godot[m
[36m@@ -17,8 +17,8 @@[m [mconfig/icon="res://icon.svg"[m
 [m
 [display][m
 [m
[31m-window/size/viewport_width=960[m
[31m-window/size/viewport_height=540[m
[32m+[m[32mwindow/size/viewport_width=1024[m
[32m+[m[32mwindow/size/viewport_height=768[m
 window/stretch/mode="canvas_items"[m
 [m
 [input][m
[36m@@ -55,6 +55,30 @@[m [mui_down={[m
 , Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":0,"physical_keycode":83,"key_label":0,"unicode":115,"echo":false,"script":null)[m
 ][m
 }[m
[32m+[m[32mup={[m
[32m+[m[32m"deadzone": 0.5,[m
[32m+[m[32m"events": [Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":0,"physical_keycode":87,"key_label":0,"unicode":119,"echo":false,"script":null)[m
[32m+[m[32m, Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":0,"physical_keycode":4194320,"key_label":0,"unicode":0,"echo":false,"script":null)[m
[32m+[m[32m][m
[32m+[m[32m}[m
[32m+[m[32mdown={[m
[32m+[m[32m"deadzone": 0.5,[m
[32m+[m[32m"events": [Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":0,"physical_keycode":83,"key_label":0,"unicode":115,"echo":false,"script":null)[m
[32m+[m[32m, Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":0,"physical_keycode":4194322,"key_label":0,"unicode":0,"echo":false,"script":null)[m
[32m+[m[32m][m
[32m+[m[32m}[m
[32m+[m[32mleft={[m
[32m+[m[32m"deadzone": 0.5,[m
[32m+[m[32m"events": [Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":0,"physical_keycode":65,"key_label":0,"unicode":97,"echo":false,"script":null)[m
[32m+[m[32m, Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":0,"physical_keycode":4194319,"key_label":0,"unicode":0,"echo":false,"script":null)[m
[32m+[m[32m][m
[32m+[m[32m}[m
[32m+[m[32mright={[m
[32m+[m[32m"deadzone": 0.5,[m
[32m+[m[32m"events": [Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":0,"physical_keycode":68,"key_label":0,"unicode":100,"echo":false,"script":null)[m
[32m+[m[32m, Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":0,"physical_keycode":4194321,"key_label":0,"unicode":0,"echo":false,"script":null)[m
[32m+[m[32m][m
[32m+[m[32m}[m
 [m
 [layer_names][m
 [m
[1mdiff --git a/stages/test_world.tscn b/stages/test_world.tscn[m
[1mindex c53f133..b11ae4b 100644[m
[1m--- a/stages/test_world.tscn[m
[1m+++ b/stages/test_world.tscn[m
[36m@@ -1,12 +1,31 @@[m
[31m-[gd_scene load_steps=3 format=3 uid="uid://djk35emyflnqt"][m
[32m+[m[32m[gd_scene load_steps=5 format=3 uid="uid://djk35emyflnqt"][m
 [m
 [ext_resource type="PackedScene" uid="uid://87sgwunspoac" path="res://player/player.tscn" id="1_6gi1n"][m
 [ext_resource type="PackedScene" uid="uid://cj00kyspwebpe" path="res://obstacles/spike.tscn" id="2_2xgme"][m
[32m+[m[32m[ext_resource type="PackedScene" uid="uid://dpauun2i4vpjj" path="res://objects/portal.tscn" id="3_fmdho"][m
[32m+[m[32m[ext_resource type="PackedScene" uid="uid://wbppobph7c7b" path="res://obstacles/bouncing_spike.tscn" id="4_3lw1i"][m
 [m
 [node name="TestWorld" type="Node2D"][m
 [m
[32m+[m[32m[node name="Spike" parent="." instance=ExtResource("2_2xgme")][m
[32m+[m[32mposition = Vector2(256, 288)[m
[32m+[m
[32m+[m[32m[node name="Portal" parent="." instance=ExtResource("3_fmdho")][m
[32m+[m[32mposition = Vector2(960, 704)[m
[32m+[m
 [node name="Player" parent="." instance=ExtResource("1_6gi1n")][m
 position = Vector2(448, 272)[m
 [m
[31m-[node name="Spike" parent="." instance=ExtResource("2_2xgme")][m
[31m-position = Vector2(240, 272)[m
[32m+[m[32m[node name="BouncingSpike" parent="." instance=ExtResource("4_3lw1i")][m
[32m+[m[32mposition = Vector2(544, 352)[m
[32m+[m[32mspeed = Vector2(300, 0)[m
[32m+[m
[32m+[m[32m[node name="StaticBody2D" type="StaticBody2D" parent="."][m
[32m+[m
[32m+[m[32m[node name="CollisionPolygon2D" type="CollisionPolygon2D" parent="StaticBody2D"][m
[32m+[m[32mpolygon = PackedVector2Array(0, 768, 1024, 768, 1024, 0, 1088, 0, 1088, 832, 0, 832)[m
[32m+[m
[32m+[m[32m[node name="StaticBody2D2" type="StaticBody2D" parent="."][m
[32m+[m
[32m+[m[32m[node name="CollisionPolygon2D" type="CollisionPolygon2D" parent="StaticBody2D2"][m
[32m+[m[32mpolygon = PackedVector2Array(0, 768, 0, 0, 1024, 0, 1024, -64, -64, -64, -64, 768)[m
