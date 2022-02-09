extends Position3D


signal rotation_changed(rotation)


func _input(event):
	if event is InputEventMouseMotion:
		var movement = event.relative
		rotation.x += -deg2rad(movement.y)
		rotation.x = clamp(rotation.x, deg2rad(-90), deg2rad(90))
		rotation.y += -deg2rad(movement.x)
		
		emit_signal("rotation_changed", rotation)
