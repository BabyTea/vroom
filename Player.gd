extends VehicleBody3D

signal dead
var test = false
# This sets the max speed
var max_rpm = 800
# This sets the rate of acceleration
var max_torque = 1400

func playerdead():
	if test == true:
		max_rpm = 1
		max_torque = 0
		$Car_Body/GPUParticles3D2.emitting = true
		emit_signal("dead")
		test = false
		print("once")

func _physics_process(delta):
	var oldspeed = Global.playerspeed
	Global.playerspeed = ((Global.playerpos - self.position)/delta).length()
	var damage = round(oldspeed - Global.playerspeed)
	if damage > 2:
		Global.playerhealth = Global.playerhealth - damage
	if Global.playerhealth <= 0:
		playerdead()
	Global.playerpos = self.position
	if Global.restart == 1:
		max_rpm = 600
		max_torque = 1200
		Global.playerhealth = 100
	if max_torque > 0:
		$Car_Body/GPUParticles3D2.emitting = false
	'''
	Car Physics and Control
	'''
	steering = lerp(steering, Input.get_axis("right","left") * 0.4, 5 * delta)
	var acceleration = Input.get_axis("backward","forward")
	var rpm = abs($rear_L_wheel.get_rpm())
	$rear_L_wheel.engine_force = acceleration * max_torque * ( 1 - rpm / max_rpm )
	rpm = abs($rear_R_wheel.get_rpm())
	$rear_R_wheel.engine_force = acceleration * max_torque * ( 1 - rpm / max_rpm )
	
	
	# Dynamic Slip
	# Adjusting the formula (7 / ((rpm / 200) + 1)) can tweak the results
	$front_L_wheel.wheel_friction_slip = lerp($front_L_wheel.wheel_friction_slip,
												9 / ((rpm / 300) + 2),
												0.1)
	$front_R_wheel.wheel_friction_slip = lerp($front_R_wheel.wheel_friction_slip,
												9 / ((rpm / 300) + 2),
												0.1)
	$rear_L_wheel.wheel_friction_slip = lerp($rear_L_wheel.wheel_friction_slip,
												7 / ((rpm / 200) + 1),
												0.1)
	$rear_R_wheel.wheel_friction_slip = lerp($rear_R_wheel.wheel_friction_slip,
												7 / ((rpm / 200) + 1),
												0.1)
	
	# E-Brake Button
	if Input.is_action_pressed("drift"):
		$rear_L_wheel.wheel_friction_slip = lerp($rear_L_wheel.wheel_friction_slip,1.3,0.5)
		$rear_R_wheel.wheel_friction_slip = lerp($rear_R_wheel.wheel_friction_slip,1.3,0.5)
	
	if Input.is_action_just_released("drift"):
		$rear_L_wheel.wheel_friction_slip = lerp($rear_L_wheel.wheel_friction_slip,5.0,0.5)
		$rear_R_wheel.wheel_friction_slip = lerp($rear_R_wheel.wheel_friction_slip,5.0,0.5)
	
	# This auto brakes the car when you're not actively accelerating
	if Input.get_axis("backward","forward") == 0:
	# Adjust the final two floats to find right balance
		brake = lerp(brake,5.0,0.1)
	
	'''
	Camera Controls
	'''
	# This smooths camera operation - Adjust the final float to adjust smoothness
	$Cam_Controller.position = lerp($Cam_Controller.position,position,0.10)
	
	# This raises the camera in acceleration - Adjust the final float to adjust smoothness
	# Also adjust the float multiplied against RPM for how far it zooms out
	$Cam_Controller.position.y = lerp($Cam_Controller.position.y,(position.y * (0.1*rpm)),0.01)

func obj_get():
	Global.packages = Global.packages - 1


func _on_ready():
	self.position = Global.playerpos
