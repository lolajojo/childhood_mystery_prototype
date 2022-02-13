class_name BasisRotator


extends Object


var _basis_corrector: LimitBasisCorrector


func _init():
	_basis_corrector = LimitBasisCorrector.new()


func free():
	_basis_corrector.free()
	.free()


func rotate_basis(
		basis: Basis,
		rotation_vector: Vector3,
		min_rotation_vector: Vector3,
		max_rotation_vector: Vector3) -> Basis:
	var basis_rotation = basis.orthonormalized().get_euler()
	var angle_to_rotate = rotation_vector - basis_rotation
#	print("%s - %s = %s" % [str(rotation_vector), str(basis_rotation), str(angle_to_rotate)])
	
	basis = _rotate_basis(basis.orthonormalized(), angle_to_rotate)
	basis = _basis_corrector.correct_basis_with_limits(
		basis, 
		min_rotation_vector, 
		max_rotation_vector)
	
	return basis

func _rotate_basis(basis: Basis, rotation_angle_rad: Vector3):
#	print("before", basis)
	print(rotation_angle_rad)
	basis = basis.rotated(basis.x, rotation_angle_rad.x)
	print("x-rotated ", basis)
	basis = basis.rotated(basis.y, rotation_angle_rad.y)
	print("y-rotated ", basis)
	basis = basis.rotated(basis.z, rotation_angle_rad.z)
	print("z-rotated ", basis)
#	print("after", basis)
	
	return basis
