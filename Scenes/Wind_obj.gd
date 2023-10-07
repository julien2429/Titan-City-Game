extends CharacterBody2D

var s = 0

func _physics_process(delta):
	
	s += 1
	if s > 100:
		if VolumeManager.wind_dir == 1:
			velocity = Vector2(150, 0)
		else:
			velocity = Vector2(-150, 0)
		s = 0
	
	
	move_and_slide()
