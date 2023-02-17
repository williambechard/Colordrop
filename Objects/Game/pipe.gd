extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var from : Node2D
onready var to : Node2D

var valve : Node2D

onready var line : Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	 pass
 

func setPipe(f:Node2D, t:Node2D):
	valve=$Valve
	line=$Line
	from = f
	to = t
	line.add_point(f.position, 0)
	line.add_point(t.position, 1)
	valve.position=Vector2(f.position.x + ((t.position.x-f.position.x)*.5), (f.position.y + ((t.position.y-f.position.y) *.5)))
	

