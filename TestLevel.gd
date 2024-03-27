extends Node3D
var game_over: PackedScene
var game_over_instance
# Called when the node enters the scene tree for the first time.
func _ready():
	game_over = load("res://GameOver.tscn")
	game_over_instance = game_over.instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.packages == 0:
		add_child(game_over_instance)
	if Global.restart == 1:
		remove_child(game_over_instance)
		Global.restart = 0