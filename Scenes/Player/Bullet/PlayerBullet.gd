extends CharacterBody2D

@export var Sprite: AnimatedSprite2D
@export var BulletDestoryEffectGenerator_scene: PackedScene

func _ready():
	Sprite.play()
	await get_tree().create_timer(2.0).timeout
	destory_bullet()

func _physics_process(delta):
	var collide = move_and_collide(velocity * delta)
	if collide:
		destory_bullet()

func destory_bullet():
	var inst = BulletDestoryEffectGenerator_scene.instantiate()
	inst.position = position + velocity / 100
	get_tree().current_scene.add_child(inst)
	queue_free()
