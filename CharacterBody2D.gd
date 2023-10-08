extends CharacterBody2D

@export var movespeed : float = 130
@export var starting_direction : Vector2 = Vector2(0,1)
# parameters/idle/blend_position
	
@onready var compass = $Compass
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")


func _ready():
	update_animation_parameters(starting_direction)
# Called when the node enters the scene tree for tshe first time.
func _physics_process(delta):
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	update_animation_parameters(input_direction)
	velocity= movespeed * input_direction
	sound_animation()
	move_and_slide()
	pick_new_state()
	rotate_compass()

func sound_animation():
	var ok = true
	if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
			$AudioStreamPlayer2D.play()

func update_animation_parameters( move_input : Vector2 ):
	
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position",move_input)
		animation_tree.set("parameters/walk/blend_position",move_input)
	else:
		$AudioStreamPlayer2D.play()

func rotate_compass():
	var angle : float
	var x: float = get_parent().x[VolumeManager.current_task]
	var y: float = get_parent().y[VolumeManager.current_task]
	
	angle = atan2( x - position[0]  , -(y - position[1]) )
	compass.rotation = angle + 3.14
		
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
