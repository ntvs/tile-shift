extends Node2D

# REFERENCES
onready var cursor = $CursorSprite
onready var gridBG = $GridBG
var sel_tile
# Declare member variables here. Examples:
var grid = []
var rows = 5
var columns = 5

var gridPosition = Vector2.ZERO
var incrementor = 1.0

var spriteWidth = 64


# Called when the node enters the scene tree for the first time.
func _ready():
	var screenSize = get_viewport_rect().size
	# Add a tile symbol 
	var scene = load("res://Symbol.tscn")
	# Setup Array
	for x in range(rows):
		grid.append([])
		for y in range(columns):
			var tile = scene.instance()
			tile.position.x = screenSize.x/2 - (2*64) + x * spriteWidth
			tile.position.y = screenSize.y/2 - (2*64) + y * spriteWidth
			add_child(tile)
			grid[x].append(tile)
			
	# Setup cursor sprite in top left of the grid
	
	cursor.position.x = screenSize.x/2 - (2*64)
	cursor.position.y = screenSize.y/2 - (2*64)
	
	# Center the grid sprite
	gridBG.position.x = screenSize.x/2
	gridBG.position.y = screenSize.y/2
	
	
	

func _physics_process(delta):
	handleMove(delta)

# Possible optimizations:
# Couple the grid indices to the movement so that when the index changes,
# the position can update with it
# Plus all this repetitive code can probably be reorganized
func handleMove(_delta):
	if Input.is_action_just_pressed("ui_up") and gridPosition.y-incrementor >= 0:
		gridPosition.y -= incrementor
		cursor.position.y -= incrementor*spriteWidth
		#print(gridPosition)
	elif Input.is_action_just_pressed("ui_down") and gridPosition.y+incrementor <= rows-1:
		gridPosition.y += incrementor
		cursor.position.y += incrementor*spriteWidth
		#print(gridPosition)
	elif Input.is_action_just_pressed("ui_left") and gridPosition.x-incrementor >= 0:
		gridPosition.x -= incrementor
		cursor.position.x -= incrementor*spriteWidth
		#print(gridPosition)
	elif Input.is_action_just_pressed("ui_right") and gridPosition.x+incrementor <= columns-1:
		gridPosition.x += incrementor
		cursor.position.x += incrementor*spriteWidth
		#print(gridPosition)
	elif Input.is_action_just_pressed("ui_accept"):
		print("Selected element: " + str(gridPosition))
		sel_tile = grid[gridPosition.x][gridPosition.y]
		print("Selected element: " + str(sel_tile.color_name))
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
