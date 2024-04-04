extends Node3D

signal deliver
signal deliver_cancel
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Global.deliver = true
		Global.deliver_loc = get_parent_node_3d().global_transform.origin
		print(get_parent_node_3d().global_transform.origin)
		emit_signal("deliver")

func _on_body_exited(body):
	if body.is_in_group("Player"):
		Global.deliver = false
		emit_signal("deliver_cancel")
