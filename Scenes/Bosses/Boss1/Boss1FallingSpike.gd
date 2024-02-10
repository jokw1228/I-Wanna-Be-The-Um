extends Node2D

var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2((randf() - 0.5) * 2, (randf() - 0.5) * 2)
	await get_tree().create_timer(5.0).timeout
	queue_free()

func _physics_process(delta):
	const accel = 200
	velocity.y += accel * delta
	position += velocity * delta
