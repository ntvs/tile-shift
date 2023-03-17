extends Node2D
#$Ball is a temp name will change it later maybe XD
onready var tile = $Ball
onready var NUM_OF_HF = tile.hframes - 1
var color_name
var rng = RandomNumberGenerator.new()

#this is just for debguing might dele this later 
func getColor(color_id):
	var color
	match color_id:
		0:
			color = "red"
		1:
			color = "green"
		2:
			color = "blue"
		3:
			color = "yellow"
		4:
			color = "purple"
		5:
			color = "grey"
		_:
			color = "None"
	return color

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var num = rng.randi_range(0,NUM_OF_HF)
	color_name = getColor(num)
	tile.frame = num
	
	 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
