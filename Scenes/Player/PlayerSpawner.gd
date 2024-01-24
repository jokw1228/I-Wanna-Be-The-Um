extends Node2D

@export var Player_scene: PackedScene

func _ready():
	var inst = Player_scene.instantiate()
	inst.position = SaveFileManager.load_position
	get_tree().current_scene.call_deferred("add_child", inst)
	queue_free()
