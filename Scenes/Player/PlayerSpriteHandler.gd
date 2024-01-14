extends Node2D

@export var PlayerAnimatedSprite2D_node: AnimatedSprite2D
@export var UmAnimatedSprite2D_node: AnimatedSprite2D

var player

func _ready():
	player = get_parent()
	PlayerAnimatedSprite2D_node.play()
	UmAnimatedSprite2D_node.play()

func update_animation():
	PlayerAnimatedSprite2D_node.flip_h = player.flip_h_state
	UmAnimatedSprite2D_node.flip_h = player.flip_h_state
	
	if player.is_floating_in_the_air_state == player.is_floating_in_the_air_type.AIR_RISING:
		PlayerAnimatedSprite2D_node.animation = "jump"
		UmAnimatedSprite2D_node.animation = "jump"
	elif player.is_floating_in_the_air_state == player.is_floating_in_the_air_type.AIR_FALLING:
		PlayerAnimatedSprite2D_node.animation = "fall"
		UmAnimatedSprite2D_node.animation = "fall"
	elif player.is_floating_in_the_air_state == player.is_floating_in_the_air_type.GROUND:
		if player.is_moving_side_to_side_state == player.is_moving_side_to_side_type.MOVING:
			PlayerAnimatedSprite2D_node.animation = "walk"
			UmAnimatedSprite2D_node.animation = "walk"
		elif player.is_moving_side_to_side_state == player.is_moving_side_to_side_type.STOP:
			PlayerAnimatedSprite2D_node.animation = "idle"
			UmAnimatedSprite2D_node.animation = "idle"
