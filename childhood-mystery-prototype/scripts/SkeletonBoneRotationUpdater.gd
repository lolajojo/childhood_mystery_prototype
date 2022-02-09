extends Position3D


export(NodePath) var skeleton_path
export(String) var bone_name

var skeleton_node: Skeleton
var _basis_corrector: LimitBasisCorrector


func _ready():
	skeleton_node = get_node(skeleton_path)
	_basis_corrector = LimitBasisCorrector.new()


func _exit_tree():
	_basis_corrector.free()


func rotate_bone(rotation_vector: Vector3):
	if skeleton_node == null:
		print("Skeleton is not set")
		return
	
	var bone_id = skeleton_node.find_bone(bone_name)
	
	if bone_id == null:
		print("Failed to found bone ", bone_name, " in skeleton ", skeleton_node)
		return
	
	var bone_pose = skeleton_node.get_bone_global_pose(bone_id)
	var bone_rotation = bone_pose.basis.get_euler()
	var angle_to_rotate = rotation_vector - bone_rotation
	
	bone_pose.basis = _rotate_basis(bone_pose.basis, angle_to_rotate)
	
	skeleton_node.set_bone_global_pose_override(bone_id, bone_pose, 1.0, true)


func _rotate_basis(basis: Basis, rotation_angle_rad: Vector3):
	basis = basis.rotated(basis.x, rotation_angle_rad.x)
	basis = basis.rotated(basis.y, rotation_angle_rad.y)
	basis = basis.rotated(basis.z, rotation_angle_rad.z)
	
	return basis
