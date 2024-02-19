extends Node2D

@export var PlayerShootEffect_node: Node
@export var audio: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerShootEffect_node.emitting = true
	SoundManager.play_sound(audio, "SFX")
	await PlayerShootEffect_node.finished
	queue_free()
