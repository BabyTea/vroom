extends Node3D

signal gameover
# SpawnPoints is the node that holds all the point markers
# So doing this makes it available as a var across the script
@onready var SpawnPoints = $SpawnPoints
@onready var selectedSpawn
# Creates an array of the spawnpoints
@onready var possiblePoints = SpawnPoints.get_children()
@onready var delivery_obj
@onready var SpawnDropoff

# Called when the node enters the scene tree for the first time.
func _ready():
	$DropOff.connect("touch", score)
	#$DropOff/DropOffLoc.connect("capture", gpstoggle)
	delivery_obj = load("res://deliverable.tscn")
	$Delivery/deliver_bar.connect("deliver_done",score)
	spawn() # This spawns the first drop-off marker
	for x in possiblePoints:
		x.get_child(1).connect("deliver",deliver_start)
		x.get_child(1).connect("deliver_cancel",deliver_cancel)

func gpstoggle():
	# Toggle Visibility for the GPS Arrow
	$GPS/GPSArrow.visible = !$GPS/GPSArrow.visible

func _process(_delta):
	# Rotate the GPS arrow to the next objective
	$GPS.position = Global.playerpos
	$GPS.look_at($DropOff.position)
	$Spawner.position = Global.playerpos
	$Spawner.look_at($DropOff.position)
	$Spawner.rotation.x = 0
	$Spawner.rotation.z = 0
	$GPS.rotation.x = 0
	$GPS.rotation.z = 0
	#
	# Grow or shrink the arrow disance based on distance to objective
	var distance = $DropOff.global_transform.origin.distance_to($GPS.global_transform.origin)
	if  distance <= 40.0:
		$GPS/GPSArrow.position.z = -8 + (2*((40-distance) / 10))
	else:
		$GPS/GPSArrow.position.z = -8.0
	

func score() -> void: 
	# When a player scores, the number of packages goes down
	Global.packages = Global.packages - 1
	if Global.packages == 0:
		deliver()
		emit_signal("gameover")
	else:
		$DropOff/AnimationPlayer.play("Delete")
		deliver()
		gpstoggle()
		# Spawn a new package
		spawn()
		

func deliver_start():
	if Global.deliver_loc == selectedSpawn.global_transform.origin:
		gpstoggle()
		$Delivery/deliver_bar/Timer.start(4.0)
		$Delivery.visible = true
		$DropOff/AnimationPlayer.play("Capture")
	else:
		pass

func deliver_cancel():
	if $Delivery/deliver_bar/Timer.get_time_left() > 0:
		gpstoggle()
		$Delivery/deliver_bar/Timer.stop()
		$Delivery.visible = false
		$DropOff/AnimationPlayer.play("Idle")
	else:
		pass

func spawn(): # Spawn Dropoff points
	# Get the current Dropoff position
	var oldpos = $DropOff.position
	while true: # Keep picking a new one until it's not the current one
		selectedSpawn = possiblePoints[randi_range(0,9)] # Pick a random spot
		if oldpos != selectedSpawn.position:
			break
	$DropOff.position = selectedSpawn.position # Move the marker to new position
	$DropOff/AnimationPlayer.play("Create")
	SpawnDropoff = selectedSpawn.get_child(0).global_transform.origin
	print(SpawnDropoff)
	

func deliver():
	var deliver_inst = delivery_obj.instantiate()
	var throw_dir = $Spawner.global_transform.origin.direction_to(SpawnDropoff)
	var throw_dis = $Spawner.global_transform.origin.distance_to(SpawnDropoff)
	var throw_height = 20
	var throw_angle = atan((throw_height + throw_dis) / throw_dis)
	var grav = 9.8
	var throw_velocity = sqrt((throw_dis * grav) / sin(2 * throw_angle))
	deliver_inst.name = selectedSpawn.name
	deliver_inst.top_level = true
	deliver_inst.position.y = $Spawner.position.y + 2
	deliver_inst.linear_velocity = throw_dir.normalized() * throw_velocity
	deliver_inst.angular_velocity.z = 2
	$Spawner.add_child(deliver_inst)
	
