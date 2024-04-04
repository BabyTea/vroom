extends Area3D

signal touch
signal capture
# If a player touches the objective, emit the 'Touch' signal
func _on_body_entered(body):
	if body.is_in_group("Player"):
		#emit_signal("capture")
		print("CAPTURE")

func _on_body_exited(body):
	if body.is_in_group("Player"):
		pass

func sigtouch():
	#emit_signal("touch")
	pass
