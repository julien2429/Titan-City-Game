extends CharacterBody2D

@export var movespeed : float = 130
@onready var camera = $RemoteTransform2D

# @export var starting_direction : Vector2 = Vector2(0,1)
# parameters/idle/blend_position
	
var rng = RandomNumberGenerator.new()
var num = 0
var s = 1
var lim = -1
var input = 0
var aux = 0



func stop():
	movespeed = 0;
	input = 0;
	num = 0;
	VolumeManager.wind_dir = 0
	

# Called when the node enters the scene tree for tshe first time.
func _physics_process(delta):
	movespeed = 130
	s = s + 1
	if (lim == -1 && s < 100):
		rotation_degrees = 0
	else:
		if (s > lim):
			aux = rng.randf_range(0, 100)
			num = rng.randf_range(1.25, 2.25)
			VolumeManager.wind_dir = 1
			if(aux < 50):
				num *= (-1)
				VolumeManager.wind_dir = -1
			lim = rng.randf_range(60, 70)
	
	if(position[1] > 1150):
		remove_child(camera)
	var input_direction = Vector2(
		0.5*Input.get_action_strength("right") - 0.5*Input.get_action_strength("left"),
		#Input.get_action_strength("down") - Input.get_action_strength("up")
		0.7 - 0.2*Input.get_action_strength("up")
	)
	#velocity= movespeed * input_direction
	
	input = 0 
	if(Input.get_action_strength("right") > Input.get_action_strength("left") ):
		input += 2.5
	else:
		if(Input.get_action_strength("right") < Input.get_action_strength("left")):
			input -= 2.5	
			
	if(rotation_degrees > 50 or rotation_degrees < -50 ):
		stop()
		FirstPass.flipped = 1
		if Input.get_action_strength("continue"):
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	#
	
	move_and_slide()
	
	if get_slide_collision_count() != 0 :
		stop()
		if (rotation_degrees > 20 or rotation_degrees < -20):
			FirstPass.crashed = 1
			if(Input.get_action_strength("continue")):
				get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		else:	
			if FirstPass.dialog == 0:
				DialogueManager.show_example_dialogue_balloon(load("res://dialogue/landing_succes.dialogue"), "start")
				FirstPass.dialog = 1
			if(Input.get_action_strength("endDialogue")):
				FirstPass.dialog = 0
				get_tree().change_scene_to_file("res://Scenes/Planet_scene.tscn")
	
	if FirstPass.dialog == 1:
		s = 0
		stop()
	
	rotation_degrees =  rotation_degrees + num
	velocity= movespeed * input_direction
	rotation_degrees += input





