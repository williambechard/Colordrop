extends CanvasLayer

onready var anim = $"AnimationPlayer"

 

# Called when the node enters the scene tree for the first time.
func _ready():
	fadeIn()
	 
	
	
func fadeIn():
	anim.play("FadeIn")

func setTarget(target):
	anim.connect("animation_finished", target, "changeScene")

func fadeOut():
	anim.play("FadeOut")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	fadeOut()
 
