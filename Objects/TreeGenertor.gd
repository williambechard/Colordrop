extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var depth
export (int) var rng

onready var circleNodeObject = preload("res://Objects/Game/CircleNode.tscn")
onready var pipeObject = preload("res://Objects/Game/pipe.tscn")

var grid = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	grid = createGrid() ##create empty grid
	fillGrid() #create nodes in the grid
	displayGrid() #setup grid node positions
	layPipes() #setup pipes between the nodes

func getNode(j, i):
	return self.get_node("circleNode["+j as String +"]["+i as String+"]")

func layPipes():
	for j in range(depth-1, 0, -1): #check through each layer of the grid, starting at the top and moving down
		var pipes = []
		for i in rng : #loop through each node in range
			if(grid[j][i]!=null): #first make sure there is even a node at the spot we are on
				for k in rng: #if there is then we now need to loop in range again, this time for the level below it
					if(grid[j-1][k]!=null): #if a node below it, then connect it! (1rst time guaranteed)
						#check for intersection if there are other pipes
						var pipeBlocked :bool = false
						#if(pipes.size()>0):
						var proposedLine := {p1=Vector2(grid[j][i].position.x,grid[j][i].position.y), p2 = Vector2(grid[j-1][k].position.x, grid[j-1][k].position.y)}
						for l in pipes: # check each line against proposed line
							if(intersect(proposedLine.p1, proposedLine.p2, Vector2(l[0].x, l[0].y), Vector2(l[1].x, l[1].y))):
								pipeBlocked=true
								
						if(!pipeBlocked):		
							var pipe = pipeObject.instance()
							pipe.setPipe(grid[j][i], grid[j-1][k])
							pipes.push_front([grid[j][i].position, grid[j-1][k].position])
							add_child(pipe, true)
					else:
						if(k==0 || k==rng-1):
							for z in range(j-2, 0, -1):
								if(grid[z][k]!=null):
									var pBlocked:bool = false
									for l in pipes: # check each line against proposed line
										if(intersect(Vector2(grid[j][i].position.x,grid[j][i].position.y), Vector2(grid[z][k].position.x, grid[z][k].position.y), Vector2(l[0].x, l[0].y), Vector2(l[1].x, l[1].y))):
											pBlocked=true
										
									if(!pBlocked):
										var pipe = pipeObject.instance()
										pipe.setPipe(grid[j][i], grid[z][k])
										pipes.push_front([grid[j][i].position, grid[z][k].position])
										add_child(pipe, true)
										break

func ccw(A,B,C):
	return (C.y-A.y) * (B.x-A.x) > (B.y-A.y) * (C.x-A.x)
	
func intersect(A,B,C,D):
	return ccw(A,C,D) != ccw(B,C,D) and ccw(A,B,C) != ccw(A,B,D)
 
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
