extends Node3D
var point1 = Vector3(0,0,0)
var point2 = Vector3(0,0,0)
var astar = AStar3D.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	point1 = $point1.position
	point2 = $point2.position
	astar.add_point(1, point1)
	astar.add_point(2, point2)
	astar.connect_points(1, 2)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
