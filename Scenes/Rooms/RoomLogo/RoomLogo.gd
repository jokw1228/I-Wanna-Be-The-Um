extends Node

@export var Logos_node: Node2D
@export var LogoSound: AudioStream

@export var RoomMainMenu_room: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	start_coroutine()

func start_coroutine():
	
	SoundManager.play_sound(LogoSound, "SFX")
	await get_tree().create_timer(0.7).timeout
	
	var tween = get_tree().create_tween()
	tween.tween_property(Logos_node, "modulate", Color(1, 1, 1, 1), 2.0)
	
	await tween.finished
	await get_tree().create_timer(1.4).timeout
	
	tween = get_tree().create_tween()
	tween.tween_property(Logos_node, "modulate", Color(1, 1, 1, 0), 0.8)
	
	await tween.finished
	await get_tree().create_timer(0.2).timeout
	
	RoomTransitionManager.room_change(RoomTransitionEffectManager.type.up_to_down, 1, RoomMainMenu_room, RoomTransitionEffectManager.type.up_to_down, 0)
