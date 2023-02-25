extends Node2D

export (Color) var color
var origColor: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setOrigColor(c):
	origColor = c
	color = c

func setColor(c):
	color=c
	$circle.modulate=c
	if(origColor==c):
		$border.modulate = Color.black
	else:
		$border.modulate = origColor
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
