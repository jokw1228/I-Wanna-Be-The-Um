extends Node2D

@export var PlayerDeadBody_scene: PackedScene

var player

func _ready():
	player = get_parent()

func _on_player_killed():
	var inst = PlayerDeadBody_scene.instantiate()
	inst.position = to_global(position)
	inst.set_velocity(get_parent().get_real_velocity())
	if player.flip_h_state:
		inst.scale.x = -1
	get_tree().current_scene.add_child(inst)
	
	player.queue_free()
