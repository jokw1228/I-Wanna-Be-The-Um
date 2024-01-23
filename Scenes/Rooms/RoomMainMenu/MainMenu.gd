extends Control

@export var PressAnyKey_node: Label
@export var SelectMenu_node: Node
@export var StartGame_node: Label
@export var EndGame_node: Label

@export var audio1: AudioStreamPlayer2D
@export var audio2: AudioStreamPlayer2D

@export var DemoScene_room: PackedScene

var state = 0;

func _input(event):
	if state == 0:
		if event is InputEventKey:
			if event.pressed:
				state = 1
				light_out(PressAnyKey_node)
				var tween = get_tree().create_tween()
				tween.tween_property(SelectMenu_node, "modulate", Color(1, 1, 1, 1), 0.1)
				light_off(EndGame_node)
				audio1.play()
				pass
	elif state == 1:
		if Input.is_action_just_pressed("down"):
			state = 2
			light_off(StartGame_node)
			light_on(EndGame_node)
			audio2.play()
		elif Input.is_action_just_pressed("jump"):
			state = 3
			light_out(StartGame_node)
			audio1.play()
			RoomTransitionManager.room_change(RoomTransitionEffectManager.type.up_to_down, true, DemoScene_room, RoomTransitionEffectManager.type.up_to_down, 0)
	elif state == 2:
		if Input.is_action_just_pressed("up"):
			state = 1
			light_on(StartGame_node)
			light_off(EndGame_node)
			audio2.play()
		elif Input.is_action_just_pressed("jump"):
			state = 3
			light_out(EndGame_node)
			audio1.play()
			RoomTransitionEffectManager.effecting(RoomTransitionEffectManager.type.up_to_down, true)
			await RoomTransitionEffectManager.effecting_end
			get_tree().quit()

func light_on(node: Node):
	var tween = get_tree().create_tween()
	tween.tween_property(node, "modulate", Color(1, 1, 1, 1), 0.1)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(node, "scale", Vector2(1, 1), 0.1)

func light_off(node: Node):
	var tween = get_tree().create_tween()
	tween.tween_property(node, "modulate", Color(1, 1, 1, 0.3), 0.1)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(node, "scale", Vector2(0.8, 0.8), 0.1)

func light_out(node: Node):
	var tween = get_tree().create_tween()
	tween.tween_property(node, "scale", Vector2(1.5,0), 0.05)
