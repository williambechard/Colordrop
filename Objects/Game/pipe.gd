extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var from : Node2D = null
onready var to : Node2D = null

onready var line : Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	 pass
 

func setPipe(f:Node2D, t:Node2D):	
	line=$Line
	from = f
	to = t
	line.add_point(f.position, 0)
	line.add_point(t.position, 1)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
