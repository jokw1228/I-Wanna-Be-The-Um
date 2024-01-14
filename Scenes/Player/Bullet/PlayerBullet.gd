extends CharacterBody2D

@export var Sprite: AnimatedSprite2D

func _ready():
	Sprite.play()
	await get_tree().create_timer(2.0).timeout
	destory_bullet()

func _physics_process(delta):
	var collide = move_and_collide(velocity * delta)
	if collide:
		destory_bullet()

func destory_bullet():
	queue_free()
