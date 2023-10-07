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



# Called when the node enters the scene tree for tshe first time.
func _physics_process(delta):
	
	s = s + 1
	if (lim == -1 && s < 100):
		rotation_degrees = 0
	else:
		if (s > lim):
			aux = rng.randf_range(0, 100)
			num = rng.randf_range(1.25, 2.25)
			VolumeManager.wind_dir = 0
			if(aux < 50):
				VolumeManager.wind_dir = 1
				num *= (-1)
			lim = rng.randf_range(100, 130)
			VolumeManager.wind_speed = num
	
	if(position[1] > 1150):
		remove_child(camera)
	var input_direction = Vector2(
		0.5*Input.get_action_strength("right") - 0.5*Input.get_action_strength("left"),
		#Input.get_action_strength("down") - Input.get_action_strength("up")
		0.7 - 0.2*Input.get_action_strength("up")
	)
	#################velocity= movespeed * input_direction
	
	input = 0 
	if(Input.get_action_strength("right") > Input.get_action_strength("left") ):
		input += 2.5
	else:
		if(Input.get_action_strength("right") < Input.get_action_strength("left")):
			input -= 2.5	
			
	if(rotation_degrees > 50 or rotation_degrees < -50 ):
		#TEXTBOX
		stop()
		if Input.get_action_strength("continue"):
			get_tree().change_scene_to_file("res://Scenes/Lose_Screen.tscn")
	#
	
	move_and_slide()
	
	if get_slide_collision_count() != 0 :
		stop()
		if (rotation_degrees > 20 or rotation_degrees < -20):
			#TEXTBOXprint
			if(Input.get_action_strength("continue")):
				get_tree().change_scene_to_file("res://Scenes/Lose_Screen.tscn")
		else:	
			#TEXTBOXprint
			if(Input.get_action_strength("continue")):
				get_tree().change_scene_to_file("res://Scenes/Planet_scene.tscn")
	
	rotation_degrees =  rotation_degrees + num
	velocity= movespeed * input_direction
	rotation_degrees += input





