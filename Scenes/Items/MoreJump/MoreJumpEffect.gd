extends Node2D

@export var sprite: AnimatedSprite2D
@export var audio: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	audio.play()
	sprite.play("effect")
	
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "modulate", Color(1, 1, 1, 0), 10/sprite.speed_scale)
	
	await tween.finished
	queue_free()
