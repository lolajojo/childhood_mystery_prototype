extends WAT.Test

var sut: LimitBasisCorrector

const min_rotation = Vector3(-rad2deg(PI/2), -rad2deg(PI/2), -rad2deg(PI/2))
const max_rotation = -min_rotation

func pre():
	sut = LimitBasisCorrector.new()


func post():
	sut.free()


func test_rotation_above_limit_x_normale():
	var expected_basis = Basis(Vector3.RIGHT, PI / 2)
	var basis = Basis(Vector3.RIGHT, deg2rad(160))
	
	basis = sut.correct_basis_with_limits(
		basis, 
		min_rotation, 
		max_rotation)
	
	asserts.is_true(
		expected_basis.is_equal_approx(basis),
		"%s is not equal to %s" % [str(expected_basis), str(basis)])


func test_rotation_under_limit_x_normale():
	var expected_basis = Basis(Vector3.RIGHT, - PI / 2)
	var basis = Basis(Vector3.RIGHT, deg2rad(-160))
	
	basis = sut.correct_basis_with_limits(
		basis, 
		min_rotation, 
		max_rotation)
	
	asserts.is_true(
		expected_basis.is_equal_approx(basis),
		"%s is not equal to %s" % [str(expected_basis), str(basis)])


func test_rotation_exceeded_y_normale():
	var expected_basis = Basis(Vector3.UP, deg2rad(90))
	var basis = Basis(Vector3.UP, deg2rad(160))
	
	basis = sut.correct_basis_with_limits(
		basis, 
		min_rotation, 
		max_rotation)
	
	asserts.is_true(expected_basis.is_equal_approx(basis),
		"%s is not equal to %s" % [str(expected_basis), str(basis)])


func test_rotation_exceeded_z_normale():
	var expected_basis = Basis(Vector3.BACK, PI / 2)
	var basis = Basis(Vector3.BACK, deg2rad(160))
	
	basis = sut.correct_basis_with_limits(
		basis, 
		min_rotation, 
		max_rotation)
	
	asserts.is_true(expected_basis.is_equal_approx(basis),
		"%s is not equal to %s" % [str(expected_basis), str(basis)])
