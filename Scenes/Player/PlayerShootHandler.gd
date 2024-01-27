extends Node2D

@export var PlayerBullet_scene: PackedScene
@export var PlayerShootEffectGenerator_scene: PackedScene

var player

func _ready():
	player = get_parent()


func _on_player_shooted():
	var inst = PlayerBullet_scene.instantiate()
	inst.position = player.position
	
	const velocity_magnitude = 320
	
	if player.is_up_or_down_state == player.is_up_or_down_type.NONE:
		if player.flip_h_state == player.flip_h_type.RIGHT:
			inst.position.x += 5
			inst.velocity = Vector2(velocity_magnitude, 0)
		elif player.flip_h_state == player.flip_h_type.LEFT:
			inst.position.x -= 5
			inst.velocity = Vector2(-velocity_magnitude, 0)
	elif player.is_up_or_down_state == player.is_up_or_down_type.UP:
		inst.position.y -= 10
		inst.velocity = Vector2(0, -velocity_magnitude)
	elif player.is_up_or_down_state == player.is_up_or_down_type.DOWN:
		inst.position.y += 10
		inst.velocity = Vector2(0, velocity_magnitude)
	
	var inst_effect = PlayerShootEffectGenerator_scene.instantiate()
	inst_effect.position = inst.position
	
	get_tree().current_scene.add_child(inst)
	get_tree().current_scene.add_child(inst_effect)
