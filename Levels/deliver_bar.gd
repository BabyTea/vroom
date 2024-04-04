extends ProgressBar

signal deliver_done
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Timer.get_time_left() > 0:
		self.value = (4.0 - $Timer.get_time_left()) / 4.0 * 100

func _on_timer_timeout():
	$Timer.stop()
	get_parent().visible = false
	emit_signal("deliver_done")
