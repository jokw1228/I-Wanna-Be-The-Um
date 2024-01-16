extends Node2D

@export var HitGroundEffectGenerator_scene: PackedScene
@export var GroundJumpEffectGenerator_scene: PackedScene
@export var DoubleJumpEffectGenerator_scene: PackedScene

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()


func _on_player_hit_ground():
	var inst = HitGroundEffectGenerator_scene.instantiate()
	inst.position = player.position
	get_tree().current_scene.add_child(inst)


func _on_player_jumped(is_ground_jump):
	if is_ground_jump == true:
		var inst = GroundJumpEffectGenerator_scene.instantiate()
		inst.position = player.position
		get_tree().current_scene.add_child(inst)
	elif is_ground_jump == false:
		var inst = DoubleJumpEffectGenerator_scene.instantiate()
		inst.position = player.position
		get_tree().current_scene.add_child(inst)
