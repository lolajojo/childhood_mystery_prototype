extends Node


export(NodePath) var rotation_updater_path


var rotation_updater


func _ready():
	rotation_updater = get_node(rotation_updater_path)


func _on_CameraPivot_rotation_changed(rotation):
	if rotation_updater == null:
		print("Rotation updater is not set")
		return
	
	rotation_updater.rotate_bone(rotation)
