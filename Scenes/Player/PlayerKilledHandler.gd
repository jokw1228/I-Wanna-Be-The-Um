extends Node2D

@export var PlayerDeadBody_scene: PackedScene

func _on_player_killed():
	var inst = PlayerDeadBody_scene.instantiate()
	inst.position = to_global(position)
	inst.set_velocity(get_parent().get_real_velocity())
	get_tree().current_scene.add_child(inst)
