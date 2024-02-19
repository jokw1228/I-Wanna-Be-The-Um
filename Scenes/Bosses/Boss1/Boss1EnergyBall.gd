extends Node2D

@export var audio: AudioStream

var velocity: Vector2

func _ready():
	SoundManager.play_sound(audio, "SFX")
	await get_tree().create_timer(5.0).timeout
	queue_free()

func _physics_process(delta):
	position += velocity * delta
