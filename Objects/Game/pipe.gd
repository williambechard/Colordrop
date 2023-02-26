extends Sprite

# Load the custom images for the mouse cursor
onready var audioPlayer = $"/root/AudioManager"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var from : Node2D
onready var to : Node2D
var open : bool = false
var openAngle : float
var closedAngle : float


var valve : Node2D
onready var line : Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Valve_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		open = !open #swap open state
		#set visual to the open state
		if(open):
			valve.rotation_degrees = openAngle
		else :
			valve.rotation_degrees = closedAngle
		get_node("/root/Tree Generator").spreadColorDown() 


func setPipe(f:Node2D, t:Node2D):
	valve=$Valve
	line=$Line
	from = f
	to = t
	line.add_point(f.position, 0)
	line.add_point(t.position, 1)
	valve.position=Vector2(f.position.x + ((t.position.x-f.position.x)*.5), (f.position.y + ((t.position.y-f.position.y) *.5)))
	openAngle = rad2deg(from.get_angle_to(to.position))	
	closedAngle = openAngle+90
	valve.rotation_degrees = closedAngle
	

