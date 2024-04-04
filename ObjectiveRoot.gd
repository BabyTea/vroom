extends Node3D

@onready var obj_anim : AnimationPlayer = $AnimationPlayer
signal touch
# Called when the node enters the scene tree for the first time.
func _ready():
	obj_anim.connect("obj_created",obj_idle)
	obj_anim.connect("obj_deleted",obj_touch)
	obj_anim.connect("obj_captured",obj_deleted)
	obj_anim.play("Create")
	

func obj_deleted():
	obj_anim.play_backwards("Delete")
	var loop : Animation = $AnimationPlayer.get_animation("Idle")
	loop.loop_mode = Animation.LOOP_NONE

func obj_idle():
	obj_anim.play("Idle")
	var loop : Animation = $AnimationPlayer.get_animation("Idle")
	loop.loop_mode = Animation.LOOP_LINEAR

func obj_created():
	obj_anim.play("Create")
	
func obj_touch():
	emit_signal("touch")
	if Global.packages > 0:
		obj_created()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



