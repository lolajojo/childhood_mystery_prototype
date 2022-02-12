extends Object


class_name LimitBasisCorrector


func correct_basis_with_limits(
	basis: Basis,
	min_rotation: Vector3, 
	max_rotation: Vector3) -> Basis:
	var x_rotation_angle = basis.get_euler().x
	basis = _correct_basis_within_limits(basis, 
										basis.x, 
										x_rotation_angle, 
										deg2rad(min_rotation.x), 
										deg2rad(max_rotation.x))
	
	var y_rotation_angle = basis.get_euler().y
	basis = _correct_basis_within_limits(basis, 
										basis.y, 
										y_rotation_angle, 
										deg2rad(min_rotation.y), 
										deg2rad(max_rotation.y))
	
	var z_rotation_angle = basis.get_euler().z
	basis = _correct_basis_within_limits(basis, 
										basis.y, 
										z_rotation_angle, 
										deg2rad(min_rotation.z), 
										deg2rad(max_rotation.z))
	
	return basis


func _correct_basis_within_limits(
	basis: Basis,
	axis,
	rotation_angle,
	min_angle,
	max_angle) -> Basis:
	if rotation_angle > max_angle:
		basis = basis.rotated(axis, -(rotation_angle - max_angle))
	elif rotation_angle < min_angle:
		basis = basis.rotated(axis, min_angle - rotation_angle)
	
	return basis

