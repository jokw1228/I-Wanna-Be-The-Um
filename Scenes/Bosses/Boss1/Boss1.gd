extends Area2D

@export var Sprite_node: AnimatedSprite2D
@export var Boss1Bullet_scene: PackedScene
@export var Boss1EnergyBall_scene: PackedScene

var hp = 100

const y_over = -16
const y_ground = 152

var player_position: Vector2

func _ready():
	player_position = Vector2.ZERO
	await get_tree().create_timer(1.0).timeout
	pattern_ready()

func _process(_delta):
	var player = get_tree().get_nodes_in_group("Player")
	if player != []:
		player_position = player[0].position

func _on_area_entered(area):
	if area.is_in_group("PlayerArea2D"):
		area.get_parent().kill_player()
		
	elif area.is_in_group("PlayerBulletArea2D"):
		area.get_parent().destory_bullet()
		
		hp -= 1

func pattern_ready():
	randomize()
	var num = randi() % 2
	if num == 0:
		pattern_0()
	elif num == 1:
		pattern_1()

func pattern_0():
	const x_offset = 32
	var is_flipped: bool = false
	
	if player_position.x < 0 + 64 + x_offset:
		position.x = player_position.x + x_offset
		is_flipped = true
	elif player_position.x > 320 - (64 + x_offset):
		position.x = player_position.x - x_offset
	else:
		var um = randi() % 2
		if um:
			position.x = player_position.x + x_offset
			is_flipped = true
		else:
			position.x = player_position.x - x_offset
	
	position.y = y_over
	Sprite_node.flip_h = is_flipped
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, y_ground), 0.3)
	await tween.finished
	
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
		await get_tree().create_timer(0.1).timeout
	
	await get_tree().create_timer(0.2).timeout
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, y_over), 0.3)
	await tween.finished
	await get_tree().create_timer(0.5).timeout
	
	pattern_ready()

func pattern_1():
	position = Vector2(160, y_over)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, y_ground), 0.3)
	await tween.finished
	
	await get_tree().create_timer(1.0).timeout
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, y_over), 1.2)
	await tween.finished
	
	await get_tree().create_timer(1.0).timeout
	pattern_ready()
