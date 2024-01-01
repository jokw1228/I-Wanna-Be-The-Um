extends Node2D

@export var LandingEffect_node: Node 

# Called when the node enters the scene tree for the first time.
func _ready():
	LandingEffect_node.emitting = true
	await get_tree().create_timer(3.0).timeout
	queue_free()
