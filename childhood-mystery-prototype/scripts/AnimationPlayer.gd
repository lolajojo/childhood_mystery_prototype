extends AnimationPlayer


func _on_Player_idling():
	get_animation("idle").loop = true
	play("idle", 0.1)


func _on_Player_start_moving():
	get_animation("walking").loop = true
	play("walking", 0.01)
