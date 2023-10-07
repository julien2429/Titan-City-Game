extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	interact()

func interact():
	if Input.get_action_strength("continue"):
		print("pressed")
	var coord_obj : Vector2 = get_node("Reactor").get_position()
	var coord_Player : Vector2= get_node("CharacterBody2D/").get_position()
	if sqrt ((coord_obj[0]-coord_Player[0])*(coord_obj[0]-coord_Player[0]) + (-coord_obj[1]+coord_Player[1])*(-coord_obj[1]+coord_Player[1])) < 100:
		$CharacterBody2D/InteractNode/InteractLabel.text = "Press Interact"
		if Input.get_action_strength("continue"):
			get_tree().change_scene_to_file("res://turnu_de_control.tscn")
	else:
		$CharacterBody2D/InteractNode/InteractLabel.text = ""
	
	
