extends Sprite2D

var sec = 1 
var dir = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position[1]+=dir
	if(sec > 40):
		sec=1
		dir*=-1
	sec+=1
	
