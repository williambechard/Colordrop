extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var audioPlayer = $"/root/AudioManager"

onready var arrow=load("res://Art/Menu/arrow.png")
onready var hand=load("res://Art/Menu/hand.png")
onready var timer = $Timer

var blink :bool = false
var fadeOut :bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(arrow)
	

func _physics_process(delta):
	if(blink):
		if(fadeOut):
			if(self.modulate.a>.25):
				self.modulate.a -= 2 * delta
			#set_modulate(lerp(get_modulate(), Color(0,0,0,0), 0.2))
		else:
			#set_modulate(lerp(get_modulate(), Color(1,1,1,1), 0.2))
			if(self.modulate.a<1):
				self.modulate.a += 2 * delta

func _on_Button_mouse_entered():
	add_color_override("font_color", Color(1,.5,.5,1))
	Input.set_custom_mouse_cursor(hand, CURSOR_POINTING_HAND)
	audioPlayer.play("res://Audio/toggle.wav")


func _on_Button_mouse_exited():
	add_color_override("font_color", Color(1,1,1,1))
	Input.set_custom_mouse_cursor(arrow, CURSOR_ARROW)


func _on_Button_pressed():
		audioPlayer.play("res://Audio/success1.wav")
		blink=true
		timer.start(.5)
		get_tree().change_scene("res://Scenes/Menu/" + get_node("SceneToLoad").editor_description)


func _on_Timer_timeout():
	fadeOut=!fadeOut

