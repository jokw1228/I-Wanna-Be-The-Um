extends Node2D

@export var PlayerBullet_scene: PackedScene

func _on_player_shooted():
	var inst = PlayerBullet_scene.instantiate()
	inst.position = to_global(position)
	get_tree().current_scene.add_child(inst)
