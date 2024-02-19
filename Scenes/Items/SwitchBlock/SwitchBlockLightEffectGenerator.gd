extends Node2D

@export var Sprite_node: AnimatedSprite2D
@export var Audio: AudioStream

func _ready():
	Sprite_node.play()
	SoundManager.play_sound(Audio, "SFX")
	
	var tween = get_tree().create_tween()
	tween.tween_property(Sprite_node, "modulate", Color(1, 1, 1, 0), 10/Sprite_node.speed_scale)
	
	await tween.finished
	queue_free()
