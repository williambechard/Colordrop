extends Label
 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var arrow=load("res://Art/Menu/arrow.png")
var hand=load("res://Art/Menu/hand.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(arrow)


	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_mouse_entered():
	add_color_override("font_color", Color(1,.5,.5,1))
	Input.set_custom_mouse_cursor(hand)


func _on_Button_mouse_exited():
	add_color_override("font_color", Color(1,1,1,1))
	Input.set_custom_mouse_cursor(arrow)
