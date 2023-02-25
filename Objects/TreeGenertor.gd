extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var depth
export (int) var rng

export (Color) var color1
export (Color) var color2
export (Color) var color3
export (Color) var color4
export (Color) var color5
export (Color) var color6
export (Color) var color7

var colors = []

onready var circleNodeObject = preload("res://Objects/Game/CircleNode.tscn")
onready var pipeObject = preload("res://Objects/Game/pipe.tscn")

var grid = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	colors.push_front(color1)
	colors.push_front(color2)
	colors.push_front(color3)
	colors.push_front(color4)
	colors.push_front(color5)
	colors.push_front(color6)
	colors.push_front(color7)
	
	grid = createEmptyGrid() ##create empty grid
	createNodes() #create nodes in the grid
	#positionNodesOnGrid() #setup grid node positions
	layPipes() #setup pipes between the nodes

func getNode(j, i):
	return self.get_node("circleNode["+j as String +"]["+i as String+"]")

	
func pipeBlock(from, to, allPipes):
	var pipeBlocked :bool = false
	
	for l in allPipes: # check each line against proposed line
		if(intersect(from, to, l[0], l[1])):
			pipeBlocked=true
			break
			
	return pipeBlocked

	
func layPipes():
	for j in range(depth-1, 0, -1): #check through each layer of the grid, starting at the top and moving down
		var pipes = []
		for i in rng : #loop through each node in range
			if(grid[j][i]!=null): #first make sure there is even a node at the spot we are on
				for k in rng: #if there is then we now need to loop in range again, this time for the level below it
					if(grid[j-1][k]!=null): #if a node below it, then connect it! (1rst time guaranteed)
						#check for intersection if there are other pipes
						if(!pipeBlock(grid[j][i].position, grid[j-1][k].position, pipes)):		
							var pipe = pipeObject.instance()
							pipe.setPipe(grid[j][i], grid[j-1][k])
							pipes.push_front([grid[j][i].position, grid[j-1][k].position])
							add_child(pipe, true)
					else: #no node below, so keep checking down only (and only if 1rst or last position)
						if(i==0 || i==rng-1):
							for z in range(j-1, 0, -1): #search down for the next node
								if(grid[z][i]!=null):
									if(!pipeBlock(grid[j][i].position, grid[z][i].position, pipes)):
										var pipe = pipeObject.instance()
										pipe.setPipe(grid[j][i], grid[z][i])
										pipes.push_front([grid[j][i].position, grid[z][i].position])
										add_child(pipe, true)
										break
					

func ccw(A,B,C):
	return (C.y-A.y) * (B.x-A.x) > (B.y-A.y) * (C.x-A.x)
	
func intersect(A,B,C,D):
	return ccw(A,C,D) != ccw(B,C,D) and ccw(A,B,C) != ccw(A,B,D)
 
func createEmptyGrid():
	var array  = []
	for j in depth:
		array.append([])
		for i in rng:
			array[j].append(null)
	return array

func setupNode(indexY, indexX, pos):
	var obj = circleNodeObject.instance()
	obj.set_name("circleNode["+indexY+"]["+indexX+"]")
	obj.position = pos
	obj.setOrigColor(colors[randi() % colors.size()])
	obj.setColor(obj.color)
	add_child(obj,true)
	return obj

func createNodes():
	grid[0][1] = setupNode('0','1',Vector2(64 + (get_viewport_rect().size[0] *.5 - (32*rng)), (depth * 64) + ((get_viewport_rect().size[1]*.5)-(32*depth))))
	 
	for j in range(1, depth):
		for i in rng:
			var createNode : bool = false
			if(j==depth-1):
				createNode = true
			else:
				if(randi() % 2==1):
					createNode = true
					
			if(createNode):
				grid[j][i] = setupNode(j as String, i as String, Vector2(((i*64) + (get_viewport_rect().size[0] *.5 - (32*rng))), (((depth - j) * 64)+ ((get_viewport_rect().size[1]*.5)-(32*depth)))))					
		
		if(grid[j][0]==null and grid[j][1]==null and grid[j][2]==null):
			var index = randi()%3
			grid[j][index]= setupNode(j as String, index as String, Vector2(((index*64) + (get_viewport_rect().size[0] *.5 - (32*rng))), (((depth - j) * 64)+ ((get_viewport_rect().size[1]*.5)-(32*depth)))))
 


func positionNodesOnGrid():
	for j in range(depth-1, -1, -1):
		for i in rng :
			if(grid[j][i]!=null):
				grid[j][i].position = Vector2(((i*64) + (get_viewport_rect().size[0] *.5 - (32*rng))), (((depth - j) * 64)+ ((get_viewport_rect().size[1]*.5)-(32*depth))))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
