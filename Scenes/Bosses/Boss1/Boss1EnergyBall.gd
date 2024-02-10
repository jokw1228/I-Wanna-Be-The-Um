extends Node2D

@export var audio: AudioStreamPlayer2D

var velocity: Vector2

func _ready():
	audio.play()
	await get_tree().create_timer(5.0).timeout
	queue_free()

func _physics_process(delta):
	position += velocity * delta
