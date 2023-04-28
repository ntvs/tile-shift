extends Node2D

# references
onready var modalBG = $ModalBG

# Called when the node enters the scene tree for the first time.
func _ready():
	#make modal BG the size of the screen
	modalBG.rect_size = get_viewport_rect().size
	modalBG.color = "d8000000"
	modalBG.rect_position = Vector2(0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
