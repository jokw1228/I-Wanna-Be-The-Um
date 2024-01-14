extends Node2D

@export var PlayerAnimatedSprite2D_node: AnimatedSprite2D
@export var UmAnimatedSprite2D_node: AnimatedSprite2D

var player

func _ready():
	player = get_parent()
	PlayerAnimatedSprite2D_node.play()
	UmAnimatedSprite2D_node.play()

func _process(_delta):
	update_animation()

func update_animation():
	PlayerAnimatedSprite2D_node.flip_h = player.flip_h_state
	UmAnimatedSprite2D_node.flip_h = player.flip_h_state
	
	if player.is_floating_in_the_air_state == player.is_floating_in_the_air_type.AIR_RISING:
		if player.is_up_or_down_state == player.is_up_or_down_type.NONE:
			PlayerAnimatedSprite2D_node.animation = "jump"
		elif player.is_up_or_down_state == player.is_up_or_down_type.UP:
			PlayerAnimatedSprite2D_node.animation = "jump_up"
		elif player.is_up_or_down_state == player.is_up_or_down_type.DOWN:
			PlayerAnimatedSprite2D_node.animation = "jump_down"
	elif player.is_floating_in_the_air_state == player.is_floating_in_the_air_type.AIR_FALLING:
		if player.is_up_or_down_state == player.is_up_or_down_type.NONE:
			PlayerAnimatedSprite2D_node.animation = "fall"
		elif player.is_up_or_down_state == player.is_up_or_down_type.UP:
			PlayerAnimatedSprite2D_node.animation = "fall_up"
		elif player.is_up_or_down_state == player.is_up_or_down_type.DOWN:
			PlayerAnimatedSprite2D_node.animation = "fall_down"
	elif player.is_floating_in_the_air_state == player.is_floating_in_the_air_type.GROUND:
		if player.is_moving_side_to_side_state == player.is_moving_side_to_side_type.MOVING:
			if player.is_up_or_down_state == player.is_up_or_down_type.NONE:
				PlayerAnimatedSprite2D_node.animation = "walk"
			elif player.is_up_or_down_state == player.is_up_or_down_type.UP:
				PlayerAnimatedSprite2D_node.animation = "walk_up"
			elif player.is_up_or_down_state == player.is_up_or_down_type.DOWN:
				PlayerAnimatedSprite2D_node.animation = "walk_down"
		elif player.is_moving_side_to_side_state == player.is_moving_side_to_side_type.STOP:
			if player.is_up_or_down_state == player.is_up_or_down_type.NONE:
				PlayerAnimatedSprite2D_node.animation = "idle"
			elif player.is_up_or_down_state == player.is_up_or_down_type.UP:
				PlayerAnimatedSprite2D_node.animation = "idle_up"
			elif player.is_up_or_down_state == player.is_up_or_down_type.DOWN:
				PlayerAnimatedSprite2D_node.animation = "idle_down"
	
	if player.is_up_or_down_state == player.is_up_or_down_type.NONE:
		UmAnimatedSprite2D_node.animation = "idle"
	elif player.is_up_or_down_state == player.is_up_or_down_type.UP:
		UmAnimatedSprite2D_node.animation = "up"
	elif player.is_up_or_down_state == player.is_up_or_down_type.DOWN:
		UmAnimatedSprite2D_node.animation = "down"
