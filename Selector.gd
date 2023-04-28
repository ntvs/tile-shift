extends KinematicBody2D


# Declare member variables here. Examples:
var velocity = Vector2.ZERO
export var acceleration = 50
export var friction = 20
export var maxSpeed = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	# Center the selector
	var screenSize = get_viewport_rect().size
	self.position.x = screenSize.x/2
	self.position.y = screenSize.y/2
	
	print("* Initialized selector")


# Per "tick" looped logic - _process() happens as fast as possible, unlike physics
func _physics_process(delta):
	handleFluidInput(delta)
	#handleInput()
	#pass

#Fluid cursor-like movement -> like smash cursor
func handleFluidInput(delta):
	var inputVector = Vector2.ZERO
	
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()
	
	if inputVector != Vector2.ZERO:
		velocity += inputVector * acceleration * delta
		velocity = velocity.clamped(maxSpeed)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_collide(velocity)

#Grid-like movement -> probably don't even need to use KinematicBody
func handleInput():
	if Input.is_action_just_pressed("ui_up"):
		#print("* You pressed up.")
		self.position.y -= 64
	elif Input.is_action_just_pressed("ui_down"):
		#print("* You pressed down.")
		self.position.y += 64
	elif Input.is_action_just_pressed("ui_left"):
		#print("* You pressed left.")
		self.position.x -= 64
	elif Input.is_action_just_pressed("ui_right"):
		#print("* You pressed right.")
		self.position.x += 64

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
