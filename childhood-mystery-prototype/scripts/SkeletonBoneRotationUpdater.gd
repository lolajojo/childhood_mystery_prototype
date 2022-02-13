extends Position3D


export(NodePath) var skeleton_path
export(String) var bone_name

var skeleton_node: Skeleton

export(Vector3) var min_rotation_vector = Vector3(-45, -90, -30)
export(Vector3) var max_rotation_vector = Vector3(45, 90, 30)

var _basis_rotator: BasisRotator

func _ready():
	skeleton_node = get_node(skeleton_path)
	_basis_rotator = BasisRotator.new()


func _exit_tree():
	_basis_rotator.free()


func rotate_bone(rotation_vector: Vector3):
	if skeleton_node == null:
		print("Skeleton is not set")
		return
	
	var bone_id = skeleton_node.find_bone(bone_name)
	
	if bone_id == null:
		print("Failed to found bone ", bone_name, " in skeleton ", skeleton_node)
		return
	
	var bone_pose = skeleton_node.get_bone_global_pose(bone_id)
	bone_pose.basis = _basis_rotator.rotate_basis(
		bone_pose.basis,
		rotation_vector,
		min_rotation_vector,
		max_rotation_vector)
	
	skeleton_node.set_bone_global_pose_override(
		bone_id, 
		bone_pose, 
		1.0, 
		true)
