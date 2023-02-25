extends Area2D


onready var arrow=load("res://Art/Menu/arrow.png")
onready var hand=load("res://Art/Menu/hand.png")

func _on_Valve_mouse_entered():
	print("Mouse Entered ", self)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	#Input.set_custom_mouse_cursor(hand, Input.CURSOR_POINTING_HAND)

func _on_Valve_mouse_exited():
	print("Mouse Exit ", self)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	#Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

 

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


