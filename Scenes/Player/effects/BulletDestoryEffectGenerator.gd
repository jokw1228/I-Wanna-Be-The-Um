extends Node2D

@export var BulletDestroyEffect_node: Node 
@export var audio: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	BulletDestroyEffect_node.emitting = true
	SoundManager.play_sound(audio, "SFX")
	await BulletDestroyEffect_node.finished
	queue_free()
