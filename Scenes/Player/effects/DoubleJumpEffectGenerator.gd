extends Node2D

@export var DoubleJumpEffect_node: Node
@export var audio: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	DoubleJumpEffect_node.emitting = true
	SoundManager.play_sound(audio, "SFX")
	await DoubleJumpEffect_node.finished
	queue_free()
