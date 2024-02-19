extends Node2D

@export var MuShootEffect_node: Node
@export var audio: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	MuShootEffect_node.emitting = true
	SoundManager.play_sound(audio, "SFX")
	await get_tree().create_timer(3.0).timeout
	queue_free()
