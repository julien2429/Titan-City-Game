extends CharacterBody2D

@export var movespeed : float = 130
@export var starting_direction : Vector2 = Vector2(0,1)
# parameters/idle/blend_position
	
@onready var compass = $Compass
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@onready var all_interactions = []
@onready var interactLabel = $InteractNode/InteractLabel


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
	move_and_slide()
	pick_new_state()
	rotate_compass()

func update_animation_parameters( move_input : Vector2 ):
	
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position",move_input)
		animation_tree.set("parameters/walk/blend_position",move_input)

func rotate_compass():
	var angle : float
	var x: float = 0
	var y: float = 0
	
	angle = atan2( x - position[0]  , -(y - position[1]) )
	print(angle)
	compass.rotation = angle + 3.14
	
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")

##################################################################################
#Interaction Methods
func _on_actionable_finder_area_entered(area):
	all_interactions.insert(0,area)
	updateInteractions()


func _on_actionable_finder_area_exited(area):
	all_interactions.erase(area)
	updateInteractions()

func updateInteractions():
	if all_interactions:
		interactLabel.text = all_interactions[0].interact_text 


