extends Node2D

@export var GroundJumpEffect_node: Node
@export var audio: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	GroundJumpEffect_node.emitting = true
	SoundManager.play_sound(audio, "SFX")
	await GroundJumpEffect_node.finished
	queue_free()
