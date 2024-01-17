extends Node2D

@export var Sprite_node: AnimatedSprite2D
@export var Audio_node: AudioStreamPlayer2D

func _ready():
	Sprite_node.play()
	Audio_node.play()
	await get_tree().create_timer(1.0).timeout
	queue_free()
