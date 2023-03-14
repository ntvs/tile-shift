extends Timer

# REFERENCES
onready var timerText = $timerText

# Declare member variables here. Examples:
# var a = 2
var initialTime = 60*5 # 5min


# Called when the node enters the scene tree for the first time.
func _ready():
	#self.start(1)
	_on_gameClock_timeout()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# This is probably really unoptimal
# Divisions on every timeout
# Plus variables created and destroyed every second
# Plus variables for the string version of the numbers
# Plus the original timeout when the total time runs out is lost
func _on_gameClock_timeout():
	var secs = initialTime%60
	var minutes = (initialTime/60)%60
	
	var secString = ""
	var minString = ""
	
	if secs < 10:
		secString = "0" + str(secs)
	else:
		secString = str(secs)
		
	if minutes < 10:
		minString = "0" + str(minutes)
	else:
		minString = str(minutes)
		
	timerText.text = minString + ":" + secString
	
	if initialTime == 0:
		self.stop()
		timerText.text = "Time's up!"
	else:
		initialTime -= 1
		self.start(1)
