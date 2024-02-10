extends Node2D

@export var sprite: AnimatedSprite2D

var velocity: Vector2

func _ready():
	sprite.play()
	await get_tree().create_timer(5.0).timeout
	queue_free()

func _physics_process(delta):
	position += velocity * delta
