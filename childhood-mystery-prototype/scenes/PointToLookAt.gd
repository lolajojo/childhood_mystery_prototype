extends Position3D


export(NodePath) var skeleton_path
export(String) var bone_name
export(float) var min_angle = deg2rad(-90)
export(float) var max_angle = deg2rad(90)

var skeleton_node: Skeleton


func _ready():
	skeleton_node = get_node(skeleton_path)


func _physics_process(delta):
	var bone_id = skeleton_node.find_bone(bone_name)
	var rest_global_pose: Transform = skeleton_node.get_bone_global_pose(bone_id)
	var target_position = skeleton_node.global_transform.xform_inv(global_transform.origin)
	
	rest_global_pose = rest_global_pose.looking_at(target_position, Vector3.UP)
	rest_global_pose.basis = rest_global_pose.basis.rotated(rest_global_pose.basis.y, deg2rad(180.0))
	
	var rotationAngle = rest_global_pose.basis.get_euler().y
	
	if rotationAngle > max_angle:
		rest_global_pose.basis = rest_global_pose.basis.rotated(rest_global_pose.basis.y, -(rotationAngle - max_angle))
	elif rotationAngle < min_angle:
		rest_global_pose.basis = rest_global_pose.basis.rotated(rest_global_pose.basis.y, min_angle - rotationAngle)
	
	skeleton_node.set_bone_global_pose_override(bone_id, rest_global_pose, 1.0, true)
