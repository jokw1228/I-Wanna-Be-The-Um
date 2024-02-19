extends Node2D

@export var sprite: AnimatedSprite2D
@export var audio: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.play_sound(audio, "SFX")
	sprite.play("effect")
	
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "modulate", Color(1, 1, 1, 0), 10/sprite.speed_scale)
	
	await tween.finished
	queue_free()
