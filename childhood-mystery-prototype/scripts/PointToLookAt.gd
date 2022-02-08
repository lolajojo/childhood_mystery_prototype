extends Position3D


export(NodePath) var skeleton_path
export(String) var bone_name
export(Vector3) var min_rotation = Vector3(-45, -90, -30)
export(Vector3) var max_rotation = Vector3(45, 90, 30)

var skeleton_node: Skeleton
var basis_corrector: LimitBasisCorrector

func _ready():
	skeleton_node = get_node(skeleton_path)
	basis_corrector = LimitBasisCorrector.new()

func _exit_tree():
	basis_corrector.free()

func _physics_process(delta):
	if skeleton_node == null:
		return
	
	var bone_id = skeleton_node.find_bone(bone_name)
	var target_position = skeleton_node.global_transform.xform_inv(global_transform.origin)
	
	var rest_global_pose: Transform = skeleton_node.get_bone_global_pose(bone_id)
	rest_global_pose = rest_global_pose.looking_at(target_position, Vector3.UP)
	rest_global_pose.basis = rest_global_pose.basis.rotated(rest_global_pose.basis.y, deg2rad(180.0))
	rest_global_pose.basis = basis_corrector.correct_basis_with_limits(
		rest_global_pose.basis,
		min_rotation, 
		max_rotation)
	
	skeleton_node.set_bone_global_pose_override(bone_id, rest_global_pose, 1.0, true)
