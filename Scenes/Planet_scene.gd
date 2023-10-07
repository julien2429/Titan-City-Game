extends Node2D

var iterator : int = 0
@export var x = []
@export var y = []
@export var interaction_type = []
# Called when the node enters the scene tree for the first time.

func _ready():
	var coords : Vector2  =get_node("Reactor").get_position()
	x.append(coords[0]) 
	y.append(coords[1])
	interaction_type.append("res://Scenes/turnu_de_control.tscn")
	coords = get_node("Oxygen_tank").get_position()
	x.append(coords[0]) 
	y.append(coords[1])
	interaction_type.append("oxygen")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	interact()

func interact():
	var ok = true
	for i in range(x.size()):
		var coord_obj : Vector2 = Vector2( x[i], y[i])
		#print(coord_obj)
		var coord_Player : Vector2= get_node("CharacterBody2D").get_position()
		if sqrt ((coord_obj[0]-coord_Player[0])*(coord_obj[0]-coord_Player[0]) + (-coord_obj[1]+coord_Player[1])*(-coord_obj[1]+coord_Player[1])) < 100:
			$CharacterBody2D/Label.text = "Press Interact"
			ok= false
			if (Input.get_action_strength("continue") and interaction_type[i]!="oxygen"):
				get_tree().change_scene_to_file(interaction_type[i])
			elif(Input.get_action_strength("continue") and interaction_type[i]=="oxygen"):
				$CharacterBody2D/O2bar.value=100
	if ok== true:
		$CharacterBody2D/Label.text = ""
	
