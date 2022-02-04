extends KinematicBody

signal start_moving
signal idling

export var speed = 15

var velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.x += 1
	
	if Input.is_action_pressed("move_left"):
		direction.z -= 1
	if Input.is_action_pressed("move_right"):
		direction.z += 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(direction, Vector3.UP)
	
	velocity = move_and_slide(velocity, Vector3.UP)
