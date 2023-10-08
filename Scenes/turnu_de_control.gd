extends Node2D

var dir : String = "Art/"

# Called when the node enters the scene tree for the first time.
func _ready():
	FirstPass.reactor_fin = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#var ok = ($EmptyPanel.texture == (dir + "Reactor_Bit_3.png"))# and $EmptyPanel2.texture == dir + "Reactor_bit_4.png" and $EmptyPanel3.texture == dir + "reactor_Bit_5.png" and $EmptyPanel4.texture == dir + "reactor_Bit_6.png")
	#if ok==true: - - - -
	if $EmptyPanel.texture == $ImagePanel1.texture and $EmptyPanel2.texture == $ImagePanel2.texture and $EmptyPanel3.texture == $ImagePanel3.texture and $EmptyPanel4.texture == $ImagePanel4.texture:
		#$Button.visible = true
		if FirstPass.reactor_fin == 1:
			FirstPass.reactor_fin = 0
			DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/react_fin.dialogue"), "start")
		#get_tree().change_scene_to_file("res://Scenes/Planet_scene.tscn")
		
		#print("juju")
	else:
		$Button.visible = false
	#	print("gg")	
	#print($EmptyPanel.texture)
	if Input.get_action_strength("endDialogue"):
		FirstPass.reactor_fin = 1
		get_tree().change_scene_to_file("res://Scenes/Planet_scene.tscn")
	


func _on_button_pressed():
	FirstPass.reactor_fin = 1
	get_tree().change_scene_to_file("res://Scenes/Planet_scene.tscn")
