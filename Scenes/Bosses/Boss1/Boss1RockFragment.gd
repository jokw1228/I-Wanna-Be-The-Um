extends Area2D

@export var sprite: AnimatedSprite2D

var angle_delta
var velocity: Vector2

func _ready():
	angle_delta = (randf() - 0.5) * 20
	velocity = Vector2( (randf() - 0.5) * 200, randf() * -200)
	sprite.animation = str(randi() % 3)
	
	await get_tree().create_timer(5.0).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.rotation += angle_delta * delta

func _physics_process(delta):
	const accel = 300
	velocity.y += accel * delta
	position += velocity * delta


func _on_area_entered(area):
	if area.is_in_group("PlayerArea2D"):
		area.get_parent().kill_player()
