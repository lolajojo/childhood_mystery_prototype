extends KinematicBody

signal start_moving
signal idling

export var speed = 15
export(NodePath) var rotation_ref_node_path
export(NodePath) var pivot_point


var velocity = Vector3.ZERO
var is_moving = false
var rotation_ref_node: Node
var pivot_node: Node


func _ready():
	rotation_ref_node = get_node(rotation_ref_node_path)
	pivot_node = get_node(pivot_point)


func _physics_process(delta):
	if is_moving:
		correct_rotation()
	
	handle_movement(delta)

# TODO: Simplify this method
func handle_movement(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_left"):
		direction.x += 1
	if Input.is_action_pressed("move_right"):
		direction.x -= 1
	
	if Input.is_action_pressed("move_forward"):
		direction.z += 1
	if Input.is_action_pressed("move_back"):
		direction.z -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
		if pivot_node != null:
			direction = direction.rotated(Vector3.UP, pivot_node.rotation.y)
		
		if not is_moving:
			is_moving = true
			emit_signal("start_moving")
	else:
		is_moving = false
		emit_signal("idling")
	
	velocity.x = speed * direction.x
	velocity.z = speed * direction.z
	
	velocity = move_and_slide(velocity, Vector3.UP)


func correct_rotation():
	if pivot_node == null || rotation_ref_node == null:
		return
	
	pivot_node.rotation.y = rotation_ref_node.rotation.y
