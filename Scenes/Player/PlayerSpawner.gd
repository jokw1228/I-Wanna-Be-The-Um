extends Node2D

@export var Player_scene: PackedScene

func _ready():
	var inst = Player_scene.instantiate()
	if SaveFileManager.is_need_to_load == true:
		SaveFileManager.is_need_to_load = false
		inst.position = SaveFileManager.load_position
	else:
		inst.position = position
	get_tree().current_scene.call_deferred("add_child", inst)
	queue_free()
