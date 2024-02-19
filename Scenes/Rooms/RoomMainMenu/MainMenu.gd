extends Control

@export var PressAnyKey_node: Label
@export var SelectMenu_node: Node
@export var StartGame_node: Label
@export var EndGame_node: Label

@export var audio1: AudioStream
@export var audio2: AudioStream
@export var audio3: AudioStream
@export var bgm: AudioStream

var state = 0;

func _ready():
	SoundManager.play_music(bgm, 0.0, "BGM")

func _input(event):
	if state == 0:
		if event is InputEventKey:
			if event.pressed:
				state = 1
				light_out(PressAnyKey_node)
				var tween = get_tree().create_tween()
				tween.tween_property(SelectMenu_node, "modulate", Color(1, 1, 1, 1), 0.1)
				light_off(EndGame_node)
				SoundManager.play_sound(audio1, "SFX")
				pass
	elif state == 1:
		if Input.is_action_just_pressed("down"):
			state = 2
			light_off(StartGame_node)
			light_on(EndGame_node)
			SoundManager.play_sound(audio2, "SFX")
		elif Input.is_action_just_pressed("jump"):
			state = 3
			light_out(StartGame_node)
			SoundManager.play_sound(audio3, "SFX")
			SoundManager.stop_music()
			SaveFileManager.load_game()
	elif state == 2:
		if Input.is_action_just_pressed("up"):
			state = 1
			light_on(StartGame_node)
			light_off(EndGame_node)
			SoundManager.play_sound(audio2, "SFX")
		elif Input.is_action_just_pressed("jump"):
			state = 3
			light_out(EndGame_node)
			SoundManager.play_sound(audio3, "SFX")
			SoundManager.stop_music()
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
