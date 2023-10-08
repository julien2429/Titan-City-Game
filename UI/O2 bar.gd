extends TextureProgressBar

@export var nr:int 

var s = 0
#var value =100

func get_oxy():
	nr = value
	return value
	
func set_oxy_bar(x):
	if (x == 0):
		value = 0
		return 
	value = x
	
func _physics_process(delta):
	
	s = s + 1
	if (s > 17):
		set_oxy_bar(get_oxy()-1)
		if(get_oxy() == 0 ):
			get_tree().change_scene_to_file("res://Scenes/deathscreen.tscn")
		s = 1
