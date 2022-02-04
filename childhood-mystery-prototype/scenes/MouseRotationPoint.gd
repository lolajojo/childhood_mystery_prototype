extends Position3D

func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		rotation.x += -deg2rad(movement.y)
		rotation.y += -deg2rad(movement.x)
