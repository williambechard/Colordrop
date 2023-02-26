extends Node2D

export (Color) var color
var origColor: Color

var colorMixer =[]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setOrigColor(c):
	origColor = c
	color = c

func clearColorMixer():
	colorMixer=[]
	
func addColor(c):
	colorMixer.push_front(c)

func mixColor():
	var mixedColor : Color
	if(colorMixer.size() > 0):
		mixedColor = colorMixer[0]
		for index in range(1, colorMixer.size()):
			mixedColor = mixedColor.linear_interpolate(colorMixer[index], 0.5)
	else:
		mixedColor=origColor
		
	setColor(mixedColor)

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
