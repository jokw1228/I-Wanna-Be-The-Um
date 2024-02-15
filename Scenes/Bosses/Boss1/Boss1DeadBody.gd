extends Node2D

@export var sprite: Sprite2D
@export var audio_uh: AudioStreamPlayer2D
@export var audio_die: AudioStreamPlayer2D
@export var audio_explosion: AudioStreamPlayer2D

@export var Rock_scene: PackedScene

var velocity: Vector2

func _ready():
	velocity = Vector2((randf() * 150) - 75, -256)
	audio_uh.play()
	
	await get_tree().create_timer(1.5).timeout
	audio_die.play()
	audio_explosion.play()
	CameraManager.apply_shake(12, 1)
	for i in range(4):
		var inst1 = Rock_scene.instantiate()
		inst1.position = Vector2(i * 320 / 4 + 32 + (randf() - 0.5) * 8, -32)
		get_tree().current_scene.add_child(inst1)

func _physics_process(delta):
	const accel = 500
	velocity.y += accel * delta
	position += velocity * delta
