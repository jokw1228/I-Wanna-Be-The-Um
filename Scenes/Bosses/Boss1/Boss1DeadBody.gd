extends Node2D

@export var sprite: Sprite2D
@export var audio_uh: AudioStream
@export var audio_die: AudioStream
@export var audio_explosion: AudioStream

@export var Rock_scene: PackedScene

@export var effect1: RoomTransitionEffectManager.type
@export var RoomToGo_room: PackedScene
@export var effect2: RoomTransitionEffectManager.type

var velocity: Vector2

func _ready():
	velocity = Vector2((randf() * 150) - 75, -256)
	SoundManager.play_sound(audio_uh, "SFX")
	
	await get_tree().create_timer(1.5).timeout
	SoundManager.play_sound(audio_die, "SFX")
	SoundManager.play_sound(audio_explosion, "SFX")
	CameraManager.apply_shake(12, 1)
	for i in range(3):
		var inst1 = Rock_scene.instantiate()
		inst1.position = Vector2(i * 320 / 3 + (320 / 6) + (randf() - 0.5) * 8, -32)
		get_tree().current_scene.add_child(inst1)
	
	await get_tree().create_timer(3.0).timeout
	var player = get_tree().get_nodes_in_group("Player")
	if player != []:
		get_tree().call_group("Player", "queue_free")
		RoomTransitionManager.room_change(effect1, 1, RoomToGo_room, effect2, 0)

func _physics_process(delta):
	const accel = 500
	velocity.y += accel * delta
	position += velocity * delta
