extends Node3D

signal gameover
# SpawnPoints is the node that holds all the point markers
# So doing this makes it available as a var across the script
@onready var SpawnPoints = $SpawnPoints

# Creates an array of the spawnpoints
@onready var possiblePoints = SpawnPoints.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	$DropOff/DropOffLoc.connect("touch", score)
	spawn() # This spawns the first drop-off marker

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func score() -> void: 
	# When a player scores, the number of packages goes down
	Global.packages = Global.packages - 1
	if Global.packages == 0:
		emit_signal("gameover")
	else:
		# Spawn a new package
		spawn()

func spawn(): # Spawn Dropoff points
	# Get the current Dropoff position
	var oldpos = $DropOff.position
	var selectedSpawn
	while true: # Keep picking a new one until it's not the current one
		selectedSpawn = possiblePoints[randi_range(0,9)] # Pick a random spot
		if oldpos != selectedSpawn.position:
			break
	$DropOff.position = selectedSpawn.position # Move the marker to new position
	
