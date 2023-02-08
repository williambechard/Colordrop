extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var allChars = []
onready var timer = get_node("Timer")

var charArray =[];

# Called when the node enters the scene tree for the first time.
func _ready():
	for _i in self.get_children():
		if(_i is Label):
			allChars.push_front(_i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	
	if(charArray.size()==0): #check if empty array
		for _char in allChars:
			charArray.push_front(_char) #if so, refill with our chars
	
	#determine random index
	var index: int = randi() % charArray.size()
	
	#pull a random character and store it	
	var character: Label = charArray[index]
	
	#now remove that character from the array
	charArray.remove(index)

	allChars[allChars.find(character)].add_color_override(
		"font_color", 
		Color(
			rand_range(.1, 1.0),
			rand_range(.1, 1.0),
			rand_range(.1, 1.0),
			1
		)
	)
	
	timer.wait_time = rand_range(.3, .75)
	 
	
