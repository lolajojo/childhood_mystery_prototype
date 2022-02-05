extends Position3D

func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		transform
		rotation.x += -deg2rad(movement.y)
		rotation.x = clamp(rotation.x, deg2rad(-90), deg2rad(90))
		rotation.y += -deg2rad(movement.x)
		print("camera_rotation_x", rotation.x)
		print("camera_rotation_y", rotation.y)
