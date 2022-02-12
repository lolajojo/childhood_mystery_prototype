extends WAT.Test

var sut: LimitBasisCorrector

const min_rotation = Vector3(-rad2deg(PI/2), -rad2deg(PI/2), -rad2deg(PI/2))
const max_rotation = -min_rotation

func pre():
	sut = LimitBasisCorrector.new()


func post():
	sut.free()

# Testing above max limit roation cases
func test_rotation_above_max_limit_x_normale():
	var expected_basis = Basis(Vector3.RIGHT, PI / 2)
	var basis = Basis(Vector3.RIGHT, deg2rad(160))
	
	_run_correction_with_assertion(
		expected_basis,
		basis)


func test_rotation_above_max_limit_y_normale():
	var expected_basis = Basis(Vector3.UP, deg2rad(90))
	var basis = Basis(Vector3.UP, deg2rad(160))
	
	_run_correction_with_assertion(
		expected_basis,
		basis)


func test_rotation_above_max_limit_z_normale():
	var expected_basis = Basis(Vector3.FORWARD, PI / 2)
	var basis = Basis(Vector3.FORWARD, deg2rad(160))
	
	_run_correction_with_assertion(
		expected_basis,
		basis)

# Testing above limit rotation with additional 360 degrees
func test_rotation_above_limit_plus_2pi_x_normale():
	var expected_basis = Basis(Vector3.RIGHT, PI * 2 + PI / 2)
	var basis = Basis(Vector3.RIGHT, deg2rad(160))
	
	_run_correction_with_assertion(
		expected_basis,
		basis)


func test_rotation_above_limit_plus_2pi_y_normale():
	var expected_basis = Basis(Vector3.UP, PI * 2 + PI / 2)
	var basis = Basis(Vector3.UP, deg2rad(160))
	
	_run_correction_with_assertion(
		expected_basis,
		basis)


func test_rotation_above_limit_plus_2pi_z_normale():
	var expected_basis = Basis(Vector3.FORWARD, PI * 2 + PI / 2)
	var basis = Basis(Vector3.FORWARD, deg2rad(160))
	
	_run_correction_with_assertion(
		expected_basis,
		basis)

# Testing under min limit rotation cases
func test_rotation_under_min_limit_x_normale():
	var expected_basis = Basis(Vector3.RIGHT, - PI / 2)
	var basis = Basis(Vector3.RIGHT, deg2rad(-160))
	
	_run_correction_with_assertion(
		expected_basis,
		basis)


func test_rotation_under_min_limit_y_normale():
	var expected_basis = Basis(Vector3.UP, - PI / 2)
	var basis = Basis(Vector3.UP, deg2rad(-160))
	
	_run_correction_with_assertion(
		expected_basis,
		basis)


func test_rotation_under_min_limit_z_normale():
	var expected_basis = Basis(Vector3.FORWARD, - PI / 2)
	var basis = Basis(Vector3.FORWARD, deg2rad(-160))
	
	_run_correction_with_assertion(
		expected_basis,
		basis)

# Tests Utility
func _run_correction_with_assertion(
		expected_basis: Basis,
		basis: Basis):
	
	basis = sut.correct_basis_with_limits(
		basis, 
		min_rotation, 
		max_rotation)
	
	asserts.is_true(
		expected_basis.is_equal_approx(basis),
		"%s is not equal to %s" % [str(expected_basis), str(basis)])
