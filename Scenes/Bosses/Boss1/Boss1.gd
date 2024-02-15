extends Area2D

@export var Sprite_node: AnimatedSprite2D
@export var audio_laser: AudioStreamPlayer2D
@export var audio_charging: AudioStreamPlayer2D
@export var MuShootEffect_scene: PackedScene
@export var Boss1Bullet_scene: PackedScene
@export var Boss1EnergyBall_scene: PackedScene
@export var Boss1Rock_scene: PackedScene
@export var Boss1FallingSpike_scene: PackedScene

var hp_max = 100
var hp = 100
signal hp_changed(hp, hp_max)

const y_over = -16
const y_ground = 152

var player_position: Vector2
var player_flip: bool

var last_pattern = -1

func _ready():
	player_position = Vector2.ZERO
	emit_signal("hp_changed", hp, hp_max)
	await get_tree().create_timer(1.0).timeout
	pattern_ready()

func _process(_delta):
	var player = get_tree().get_nodes_in_group("Player")
	if player != []:
		player_position = player[0].position
		player_flip = player[0].flip_h_state

func _on_area_entered(area):
	if area.is_in_group("PlayerBulletArea2D"):
		area.get_parent().destory_bullet()
		hp -= 1
		hp_changed.emit(hp, hp_max)
		BossHitEffect()

func BossHitEffect():
	Sprite_node.modulate = Color(1, 0.6, 0.6, 1)
	await get_tree().create_timer(0.1).timeout
	Sprite_node.modulate = Color(1, 1, 1, 1)

func pattern_ready():
	randomize()
	var num
	while true:
		num = randi() % 3
		if num != last_pattern:
			break
	if num == 0:
		pattern_0()
	elif num == 1:
		pattern_1()
	elif num == 2:
		pattern_2()
	last_pattern = num

func pattern_0():
	const x_offset = 32
	var is_flipped: bool = true
	
	if player_position.x < 0 + 64 + x_offset:
		position.x = player_position.x + x_offset
		is_flipped = true
	elif player_position.x > 320 - (64 + x_offset):
		position.x = player_position.x - x_offset
		is_flipped = false
	else:
		if player_flip:
			position.x = player_position.x - x_offset
			is_flipped = false
		else:
			position.x = player_position.x + x_offset
			is_flipped = true
	
	position.y = y_over
	Sprite_node.flip_h = is_flipped
	
	Sprite_node.animation = "laser"
	audio_laser.play()
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, y_ground), 0.3)
	await tween.finished
	
	Sprite_node.animation = "landing"
	Sprite_node.speed_scale = 16
	Sprite_node.play()
	await Sprite_node.animation_finished
	Sprite_node.animation = "idle"
	
	await get_tree().create_timer(0.2).timeout
	
	const bullet_speed = 320
	
	for i in range(3):
		var inst = Boss1Bullet_scene.instantiate()
		inst.position = position
		inst.position.x += 5 if !is_flipped else -5
		inst.velocity = Vector2(bullet_speed, 0)
		if is_flipped:
			inst.velocity.x *= -1
		get_tree().current_scene.add_child(inst)
		var audio = MuShootEffect_scene.instantiate()
		audio.position = inst.position
		get_tree().current_scene.add_child(audio)
		await get_tree().create_timer(0.1).timeout
	
	await get_tree().create_timer(0.2).timeout
	
	Sprite_node.animation = "landing"
	Sprite_node.speed_scale = 16
	Sprite_node.play_backwards()
	await Sprite_node.animation_finished
	Sprite_node.animation = "laser"
	audio_laser.play()
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, y_over), 0.3)
	await tween.finished
	
	await get_tree().create_timer(0.5).timeout
	pattern_ready()

func pattern_1():
	if player_position.x > 160:
		Sprite_node.flip_h = false
	else:
		Sprite_node.flip_h = true
	
	position = Vector2(160, y_over)
	
	Sprite_node.animation = "laser"
	audio_laser.play()
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, y_ground), 0.3)
	await tween.finished
	
	Sprite_node.animation = "landing"
	Sprite_node.speed_scale = 16
	Sprite_node.play()
	await Sprite_node.animation_finished
	Sprite_node.animation = "idle"
	await get_tree().create_timer(0.2).timeout
	
	const charging_time = 1.0
	audio_charging.play()
	energy_charging(charging_time)
	await get_tree().create_timer(charging_time).timeout
	
	const rising_duration = 1.2
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, y_over), rising_duration)
	Sprite_node.animation = "rising"
	
	#barrage
	create_spinning_barrage(rising_duration, 36, randi(), 32 * choose_pos_or_neg(), 128)
	create_spinning_barrage(rising_duration, 88, randi(), 12 * choose_pos_or_neg(), 64)
	create_spinning_barrage(rising_duration, 24, randi(), 96 * choose_pos_or_neg(), 196)
	
	await tween.finished
	
	await get_tree().create_timer(2.0).timeout
	pattern_ready()

func energy_charging(time):
	for i in range(10):
		await get_tree().create_timer(time/25).timeout
		Sprite_node.modulate = Color(0.5, 0.5, 0.5, 1)
		await get_tree().create_timer(time/25).timeout
		Sprite_node.modulate = Color(1, 1, 1, 1)

func create_spinning_barrage(duration, shoot_times, angle_start, angle_delta, speed):
	var delay = duration / shoot_times
	for i in range(shoot_times):
		var inst = Boss1EnergyBall_scene.instantiate()
		inst.position = position
		inst.velocity = Vector2(cos( angle_start + i * angle_delta ), sin( angle_start + i * angle_delta )) * speed
		get_tree().current_scene.add_child(inst)
		await get_tree().create_timer(delay).timeout

func choose_pos_or_neg() -> int:
	var array = [-1, 1]
	return array[randi() % 2]

func pattern_2():
	if player_position.x > 160:
		Sprite_node.flip_h = false
		position = Vector2(40, y_over)
	else:
		Sprite_node.flip_h = true
		position = Vector2(320-40, y_over)
	
	Sprite_node.animation = "laser"
	audio_laser.play()
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, y_ground), 0.3)
	await tween.finished
	
	Sprite_node.animation = "landing"
	Sprite_node.speed_scale = 16
	Sprite_node.play()
	await Sprite_node.animation_finished
	Sprite_node.animation = "idle"
	await get_tree().create_timer(0.2).timeout
	
	##just do it
	for i in range(3):
		var inst = Boss1Rock_scene.instantiate()
		inst.position = Vector2(player_position.x, -32)
		get_tree().current_scene.add_child(inst)
		await get_tree().create_timer(0.5).timeout
	
	for i in range(10):
		var inst1 = Boss1FallingSpike_scene.instantiate()
		inst1.position = Vector2(i * 320 / 10 + 16 + (randf() - 0.5) * 8, -16)
		get_tree().current_scene.add_child(inst1)
	
	#end
	await get_tree().create_timer(0.2).timeout
	
	Sprite_node.animation = "landing"
	Sprite_node.speed_scale = 16
	Sprite_node.play_backwards()
	await Sprite_node.animation_finished
	Sprite_node.animation = "laser"
	audio_laser.play()
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, y_over), 0.3)
	await tween.finished
	
	await get_tree().create_timer(1.0).timeout
	pattern_ready()
