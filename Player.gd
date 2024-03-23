extends VehicleBody3D

# This sets the max speed
var max_rpm = 600
# This sets the rate of acceleration
var max_torque = 1600

func _physics_process(delta):
	
	'''
	Car Physics and Control
	'''
	steering = lerp(steering, Input.get_axis("right","left") * 0.4, 5 * delta)
	var acceleration = Input.get_axis("backward","forward")
	var rpm = abs($rear_L_wheel.get_rpm())
	$rear_L_wheel.engine_force = acceleration * max_torque * ( 1 - rpm / max_rpm )
	rpm = abs($rear_R_wheel.get_rpm())
	$rear_R_wheel.engine_force = acceleration * max_torque * ( 1 - rpm / max_rpm )
	
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
