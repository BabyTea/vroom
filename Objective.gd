extends Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	var obj = get_parent()
	if body.is_in_group("Player"):
		if obj.visible == true:
			body.obj_get()
			obj.visible = false
