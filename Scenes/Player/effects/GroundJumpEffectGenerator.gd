extends Node2D

@export var GroundJumpEffect_node: Node
@export var audio_node: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	GroundJumpEffect_node.emitting = true
	audio_node.play()
	await get_tree().create_timer(3.0).timeout
	queue_free()
