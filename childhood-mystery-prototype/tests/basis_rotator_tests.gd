extends WAT.Test


var sut: BasisRotator


func pre():
	sut = BasisRotator.new()


func post():
	sut.free()


func first_test():
	pass
