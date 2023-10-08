extends Node2D

var iterator : int = 1
@export var x = []
@export var y = []
@export var interaction_type = []
@export var enabled =[]
# Called when the node enters the scene tree for the first time.

func _ready():
	
	$CharacterBody2D.position[0] = VolumeManager.x_player
	$CharacterBody2D.position[1] = VolumeManager.y_player
	$CharacterBody2D/O2bar.value = VolumeManager.oxygen
	
	FirstPass.reactor_fin = 1
	if FirstPass.on_titan == 1:
		FirstPass.on_titan = 0
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/Titan_intro.dialogue"), "start")
		
	
	var coords : Vector2  =get_node("Oxygen_tank").get_position()
	x.append(coords[0]) 
	y.append(coords[1])
	enabled.append(true)
	interaction_type.append("oxygen")
	
	coords = get_node("Reactor").get_position()
	x.append(coords[0]) 
	y.append(coords[1])
	enabled.append(true)
	interaction_type.append("res://Scenes/turnu_de_control.tscn")
	
	coords = get_node("BadSat").get_position()
	x.append(coords[0]) 
	y.append(coords[1])
	enabled.append(true)
	interaction_type.append("badsat")
	
	coords = get_node("GoodSat").get_position()
	x.append(coords[0]) 
	y.append(coords[1])
	enabled.append(true)
	interaction_type.append("goodsat")
	
	coords = get_node("RocketShip/Rocket").get_position()
	x.append(coords[0]) 
	y.append(coords[1])
	enabled.append(true)
	interaction_type.append("rocket")
	
	$GoodSat.visible= false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	VolumeManager.x_player = $CharacterBody2D.position[0]  
	VolumeManager.y_player = $CharacterBody2D.position[1]
	VolumeManager.oxygen =  $CharacterBody2D/O2bar.value
	if FirstPass.reactor_fin == 1:
		FirstPass.reactor_fin = 0
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/Titan_reactor_done.dialogue"), "start")
	
	if FirstPass.sat_fin == 1:
		FirstPass.sat_fin = 0
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/Titan_finish.dialogue"), "start")
	
	if Input.get_action_strength("escape"):
		get_tree().change_scene_to_file("res://Scenes/pause.tscn")
	interact()
	

func interact():
	var ok = true
	for i in range(x.size()):
		var coord_obj : Vector2 = Vector2( x[i], y[i])
		#print(coord_obj)
		var coord_Player : Vector2= Vector2($CharacterBody2D.position[0],$CharacterBody2D.position[1]) #get_node("CharacterBody2D").get_position()
		if sqrt ((coord_obj[0]-coord_Player[0])*(coord_obj[0]-coord_Player[0]) + (-coord_obj[1]+coord_Player[1])*(-coord_obj[1]+coord_Player[1])) < 100:
			$CharacterBody2D/Label.text = "Press E"
			ok= false
			if (Input.get_action_strength("continue") and( i == VolumeManager.current_task or i == 0)):
				if(interaction_type[i]=="res://Scenes/turnu_de_control.tscn" and enabled[i]==true):
					VolumeManager.oxygen =  $CharacterBody2D/O2bar.value

					get_tree().change_scene_to_file(interaction_type[i])
					enabled[i]=false
					VolumeManager.current_task+=1
				elif(interaction_type[i]=="badsat" and enabled[i]==true):
					VolumeManager.current_task+=1
					enabled[i]=false
					$BadSat/CollisionPolygon2D.disabled = true
					$BadSat.visible = false
				elif(interaction_type[i]=="goodsat" and enabled[i]==true):
					VolumeManager.current_task+=1
					enabled[i]=false
					$GoodSat.visible = true
					FirstPass.sat_fin = 1
				elif(interaction_type[i]=="rocket" and enabled[i]==true):
					get_tree().change_scene_to_file("res://Scenes/winscene.tscn")
				elif(interaction_type[i]=="oxygen"):
					$CharacterBody2D/O2bar.value=100
	if ok== true:
		$CharacterBody2D/Label.text = ""
	
