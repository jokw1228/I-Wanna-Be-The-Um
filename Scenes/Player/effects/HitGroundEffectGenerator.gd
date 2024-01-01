extends Node2D

@export var HitGroundEffect_node: Node 

# Called when the node enters the scene tree for the first time.
func _ready():
	HitGroundEffect_node.emitting = true
	await get_tree().create_timer(3.0).timeout
	queue_free()
