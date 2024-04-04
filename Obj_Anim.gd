extends AnimationPlayer

signal obj_created
signal obj_deleted
signal obj_captured
signal touch
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_animation_finished(anim_name):
	if anim_name == "Create":
		emit_signal("obj_created")
	elif anim_name == "Delete":
		emit_signal("obj_deleted")
	elif anim_name == "Capture":
		emit_signal("obj_captured")


func _on_current_animation_changed(_name):
	pass
