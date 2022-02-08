extends Position3D

# Editor
export(NodePath) var skeleton_path
export(String) var bone_name 

export(NodePath) var target_node_path

export(Vector3) var min_rotation_vector = Vector3(-45, -90, -30)
export(Vector3) var max_rotation_vector = Vector3(45, 90, 30)


var skeleton_node: Skeleton
var target_node: Node

var basis_corrector: LimitBasisCorrector

# Lifecycle
func _ready():
	skeleton_node = get_node(skeleton_path)
	target_node = get_node(target_node_path)
	basis_corrector = LimitBasisCorrector.new()


func _exit_tree():
	basis_corrector.free()


func _physics_process(delta):
	if skeleton_node == null:
		return
	
	var bone_id = skeleton_node.find_bone(bone_name)
	var point_to_look_at = target_node.get_global_origin()
	var target_position = skeleton_node.global_transform.xform_inv(point_to_look_at)
	
	var rest_global_pose: Transform = skeleton_node.get_bone_global_pose(bone_id)
	rest_global_pose = rest_global_pose.looking_at(target_position, Vector3.UP)
	rest_global_pose.basis = rest_global_pose.basis.rotated(rest_global_pose.basis.y, deg2rad(180.0))
	rest_global_pose.basis = basis_corrector.correct_basis_with_limits(
		rest_global_pose.basis,
		min_rotation_vector, 
		max_rotation_vector)
	
	skeleton_node.set_bone_global_pose_override(bone_id, rest_global_pose, 1.0, true)
