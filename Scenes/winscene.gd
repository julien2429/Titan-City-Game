extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/the_end.dialogue"), "start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	VolumeManager.oxygen = 100
	VolumeManager.x_player = 0 
	VolumeManager.y_player =0
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
