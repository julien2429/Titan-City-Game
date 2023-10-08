extends Node2D

func _ready():
	$AudioStreamPlayer2D.play()
	if FirstPass.landing_begin == 1:
		FirstPass.dialog = 1
		FirstPass.landing_begin == 0
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/landing_begin.dialogue"), "start")
	return
	
func _physics_process(delta):
	if(Input.get_action_strength("endDialogue")):
		FirstPass.dialog = 0
