extends Node2D

@export var audio: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.play_sound(audio, "SFX")
	await get_tree().create_timer(2.0).timeout
	queue_free()
