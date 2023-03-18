extends Node2D

# REFERENCES
onready var cursor = $CursorSprite
onready var gridBG = $GridBG
var sel_tile
var previousX
var previousY
# Declare member variables here. Examples:
var grid = []
var rows = 7
var columns = 7

var gridPosition = Vector2.ZERO
var incrementor = 1.0
enum {NONE , UP , DOWN , LEFT , RIGHT}
var directionToSwap = NONE
var spriteWidth = 64
var spriteOffset = 3
var lastColorId = -1
var selected = false
var temp
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
			#times 2 to split the screen in haft
			tile.position.x = screenSize.x/2 - (spriteOffset * spriteWidth) + x * spriteWidth
			tile.position.y = screenSize.y/2 - (spriteOffset * spriteWidth) + y * spriteWidth
			add_child(tile)
			grid[x].append(tile)
			
	# Setup cursor sprite in top left of the grid
	
	cursor.position.x = screenSize.x/2 - (spriteOffset * spriteWidth)
	cursor.position.y = screenSize.y/2 - (spriteOffset * spriteWidth)
	
	# Center the grid sprite
	gridBG.position.x = screenSize.x/2
	gridBG.position.y = screenSize.y/2
	
	
func _on_Button_pressed(extra_arg_0: String) -> void:
	print(extra_arg_0)

func _physics_process(delta):
	handleMove(delta)
	
func _move():
	print("swapped")
	temp = grid[gridPosition.x][gridPosition.y].tile.frame
	grid[gridPosition.x][gridPosition.y].tile.frame = sel_tile
	grid[previousX][previousY].tile.frame = temp
	selected  = !selected
# Possible optimizations:
# Couple the grid indices to the movement so that when the index changes,
# the position can update with it
# Plus all this repetitive code can probably be reorganized
func handleMove(_delta):
	
	if Input.is_action_just_pressed("ui_up") and gridPosition.y-incrementor >= 0:
		gridPosition.y -= incrementor
		cursor.position.y -= incrementor*spriteWidth
		if(selected):
			_move()
	elif Input.is_action_just_pressed("ui_down") and gridPosition.y+incrementor <= rows-1:
		gridPosition.y += incrementor
		cursor.position.y += incrementor*spriteWidth
		if(selected):
			_move()
	elif Input.is_action_just_pressed("ui_left") and gridPosition.x-incrementor >= 0:
		gridPosition.x -= incrementor
		cursor.position.x -= incrementor*spriteWidth
		if(selected):
			_move()
	elif Input.is_action_just_pressed("ui_right") and gridPosition.x+incrementor <= columns-1:
		gridPosition.x += incrementor
		cursor.position.x += incrementor*spriteWidth
		if(selected):
			_move()
	elif Input.is_action_just_pressed("ui_accept"):
		if !selected:
			print("Selected element: " + str(gridPosition))
			sel_tile = grid[gridPosition.x][gridPosition.y].tile.frame
			previousX = gridPosition.x
			previousY = gridPosition.y
			selected = !selected
			
		
		
		
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
