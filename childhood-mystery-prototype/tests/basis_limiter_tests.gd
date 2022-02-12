extends WAT.Test

var sut: LimitBasisCorrector

const min_rotation = Vector3(-rad2deg(PI/2), -rad2deg(PI/2), -rad2deg(PI/2))
const max_rotation = -min_rotation

func pre():
	sut = LimitBasisCorrector.new()


func post():
	sut.free()


func test_rotation_exceeded_left():
	var expected_basis = Basis(Vector3.UP, -PI / 2)
	var basis = Basis(Vector3.UP, PI)
	
	basis = sut.correct_basis_with_limits(
		basis, 
		min_rotation, 
		max_rotation)
	
	asserts.is_true(expected_basis.is_equal_approx(basis))
