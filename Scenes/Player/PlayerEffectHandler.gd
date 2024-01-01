extends Node2D

@export var LandingEffectGenerator_scene: PackedScene
@export var GroundJumpEffectGenerator_scene: PackedScene
@export var DoubleJumpEffectGenerator_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_player_hit_ground():
	var inst = LandingEffectGenerator_scene.instantiate()
	inst.position = to_global(position)
	get_tree().current_scene.add_child(inst)
