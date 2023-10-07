extends Node2D

var s = 0

func _physics_process(delta):
	
	s += 1
	
	if s > 70:
		s = 300
		if(Input.get_action_strength("continue")):
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

