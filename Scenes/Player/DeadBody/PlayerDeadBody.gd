extends Node2D

var velocity_vector = Vector2.ZERO

func _ready():
	await get_tree().create_timer(1.0).timeout
	queue_free()

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if velocity_vector.length() > 0:
		velocity_vector = velocity_vector.normalized() * (velocity_vector.length() - 100 * delta)#수정해야함
	position += velocity_vector * delta

func set_velocity(player_velocity):
	velocity_vector = player_velocity * -1 * 0.3
