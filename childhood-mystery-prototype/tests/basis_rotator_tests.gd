extends WAT.Test


var sut: BasisRotator


const min_rotation = Vector3(-rad2deg(PI/2), -rad2deg(PI/2), -rad2deg(PI/2))
const max_rotation = -min_rotation


func pre():
	sut = BasisRotator.new()


func post():
	sut.free()

# Test simple one axis rotation
func test_x_normale_rotation():
	var expected_basis = Basis(Vector3.RIGHT, deg2rad(60))
	var rotation_vector = Vector3(deg2rad(60), 0, 0)
	
	_run_rotation_with_assertion(expected_basis, rotation_vector)


func test_y_normale_rotation():
	var expected_basis = Basis(Vector3.UP, deg2rad(60))
	var rotation_vector = Vector3(0, deg2rad(60), 0)
	
	_run_rotation_with_assertion(expected_basis, rotation_vector)


func test_z_normale_rotation():
	var expected_basis = Basis(Vector3.BACK, deg2rad(60))
	var rotation_vector = Vector3(0, 0, deg2rad(60))
	
	_run_rotation_with_assertion(expected_basis, rotation_vector)


# Test multiple axis rotation
func test_two_axis_rotation():
	var expected_basis = Basis(
		Vector3(0, 1, 0), 
		Vector3(0, 0, -1), 
		Vector3(-1, 0, 0))
	var rotation_vector = Vector3(deg2rad(-90), deg2rad(-90), 0)
	
	_run_rotation_with_assertion(expected_basis, rotation_vector)


func test_three_axis_rotation():
	var expected_basis = Basis(
		Vector3(0, 0, 1), 
		Vector3(0, 1, 0), 
		Vector3(-1, 0, 0))
	var rotation_vector = Vector3(deg2rad(-90), deg2rad(-90), deg2rad(-90))
	
	_run_rotation_with_assertion(expected_basis, rotation_vector)

# Tests Utility
func _run_rotation_with_assertion(
		expected_basis: Basis,
		rotation_vector):
	
	var result_basis = sut.rotate_basis(
		Basis(),
		rotation_vector,
		min_rotation,
		max_rotation)
	
	asserts.is_true(
		expected_basis.is_equal_approx(result_basis),
		"%s is not equal to %s" % [str(expected_basis), str(result_basis)])
