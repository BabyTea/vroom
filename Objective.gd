extends Area3D

signal touch

# If a player touches the objective, emit the 'Touch' signal
func _on_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("touch")
