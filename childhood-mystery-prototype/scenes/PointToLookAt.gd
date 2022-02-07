extends Position3D


export(NodePath) var skeleton_path
export(String) var bone_name
export(float) var min_angle = deg2rad(-90)
export(float) var max_angle = deg2rad(90)
export(Vector3) var max_rotation = Vector3(45, 90, 30)
export(Vector3) var min_rotation = Vector3(-45, -90, -30)

var skeleton_node: Skeleton


func _ready():
	skeleton_node = get_node(skeleton_path)


func _physics_process(delta):
	var bone_id = skeleton_node.find_bone(bone_name)
	var rest_global_pose: Transform = skeleton_node.get_bone_global_pose(bone_id)
	var target_position = skeleton_node.global_transform.xform_inv(global_transform.origin)
	
	rest_global_pose = rest_global_pose.looking_at(target_position, Vector3.UP)
	rest_global_pose.basis = rest_global_pose.basis.rotated(rest_global_pose.basis.y, deg2rad(180.0))
	rest_global_pose.basis = correct_basis_with_limits(rest_global_pose.basis)
	
	skeleton_node.set_bone_global_pose_override(bone_id, rest_global_pose, 1.0, true)


func correct_basis_with_limits(basis: Basis):
	var x_rotation_angle = basis.get_euler().x
	basis = correct_basis_within_limits(basis, 
										basis.x, 
										x_rotation_angle, 
										deg2rad(min_rotation.x), 
										deg2rad(max_rotation.x))
	
	var y_rotation_angle = basis.get_euler().y
	basis = correct_basis_within_limits(basis, 
										basis.y, 
										y_rotation_angle, 
										deg2rad(min_rotation.y), 
										deg2rad(max_rotation.y))
	
	var z_rotation_angle = basis.get_euler().z
	basis = correct_basis_within_limits(basis, 
										basis.y, 
										z_rotation_angle, 
										deg2rad(min_rotation.z), 
										deg2rad(max_rotation.z))
	
	return basis


func correct_basis_within_limits(basis: Basis, axis, rotation_angle, min_angle, max_angle):
	if rotation_angle > max_angle:
		basis = basis.rotated(axis, -(rotation_angle - max_angle))
	elif rotation_angle < min_angle:
		basis = basis.rotated(axis, min_angle - rotation_angle)
	
	return basis
