extends AnimationPlayer

func _enter_tree():
	get_animation("Idle").loop = true
	play("Idle")
