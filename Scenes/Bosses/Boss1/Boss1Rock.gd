extends Area2D

@export var sprite: Sprite2D
@export var fragment_scene: PackedScene
@export var effect_scene: PackedScene
@export var audio: AudioStream

var angle_delta
var velocity: Vector2

func _ready():
	angle_delta = (randf() - 0.5) * 20
	velocity = Vector2.ZERO
	SoundManager.play_sound(audio, "SFX")

func _process(delta):
	sprite.rotation += angle_delta * delta

func _physics_process(delta):
	const accel = 500
	velocity.y += accel * delta
	position += velocity * delta


func _on_body_entered(_body):
	for i in range(3):
		var inst = fragment_scene.instantiate()
		inst.position = position
		get_tree().current_scene.add_child(inst)
	CameraManager.apply_shake(2.0, 5)
	var inst2 = effect_scene.instantiate()
	inst2.position = position
	get_tree().current_scene.add_child(inst2)
	queue_free()
