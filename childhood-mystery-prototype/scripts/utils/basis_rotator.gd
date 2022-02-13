extends Object


var _basis_corrector: LimitBasisCorrector


func _init():
	_basis_corrector = LimitBasisCorrector.new()


func free():
	_basis_corrector.free()
	.free()

func smth(
		transform: Transform,
		rotation_vector: Vector3,
		min_rotation_vector: Vector3,
		max_rotation_vector: Vector3) -> Transform:
	var bone_rotation = transform.basis.get_euler()
	var angle_to_rotate = rotation_vector - bone_rotation
	print("%s - %s = %s" % [str(rotation_vector), str(bone_rotation), str(angle_to_rotate)])
	
	transform.basis = _rotate_basis(transform.basis, angle_to_rotate)
	transform.basis = _basis_corrector.correct_basis_with_limits(
		transform.basis, 
		min_rotation_vector, 
		max_rotation_vector)
	
	return transform

func _rotate_basis(basis: Basis, rotation_angle_rad: Vector3):
	print("before", basis)
	basis = basis.rotated(basis.x, rotation_angle_rad.x)
	print("x-rotated ", basis)
	basis = basis.rotated(basis.y, rotation_angle_rad.y)
	print("y-rotated ", basis)
	basis = basis.rotated(basis.z, rotation_angle_rad.z)
	print("z-rotated ", basis)
	print("after", basis)
	
	return basis
