extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var depth
export (int) var rng

onready var circleNodeObject = preload("res://Objects/Game/CircleNode.tscn")


var grid = [];
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	grid = createGrid()
	#print(grid)
	fillGrid()
	#print(grid)
	layPipes()
	displayGrid()

func layPipes():
	for j in range(depth-1, 0, -1):
		var noConnections : bool = true
		for i in  rng : #check one layer down in depth for a node
			if(grid[j][i]!=null):
				if(grid[j-1][i]!=null):
					noConnections =false
					#connect current node to the found one
					print(self.get_node("circleNode["+j as String +"]["+i as String+"]"))
		if(noConnections):
			print("no connections")
			

func createGrid():
	var array  = []
	for j in depth:
		array.append([])
		for i in rng:
			array[j].append(null)
	return array
	
func fillGrid():
	grid[0][1] =circleNodeObject.instance()
	grid[0][1].set_name("circleNode["+"0"+"]["+"1"+"]")
	add_child(grid[0][1],true)
	
	for j in range(1, depth):
		for i in rng:
			if(j==depth-1):
				grid[j][i]= circleNodeObject.instance()
				grid[j][i].set_name("circleNode["+j as String +"]["+i as String+"]")
				add_child(grid[j][i],true)
			else:
				if(randi() % 2==1):
					grid[j][i]= circleNodeObject.instance()
					grid[j][i].set_name("circleNode["+j as String +"]["+i as String+"]")
					add_child(grid[j][i],true)
					
		if(grid[j][0]==null and grid[j][1]==null and grid[j][2]==null):
			var index = randi()%3
			grid[j][index]= circleNodeObject.instance()
			grid[j][index].set_name("circleNode["+j as String +"]["+index as String+"]")
			add_child(grid[j][index],true)

func displayGrid():
	for j in range(depth-1, -1, -1):
		for i in  rng :
			if(grid[j][i]!=null):
				grid[j][i].position = Vector2(((i*64) + (get_viewport_rect().size[0] *.5 - (32*rng))), (((depth - j) * 64)+ ((get_viewport_rect().size[1]*.5)-(32*depth))))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
