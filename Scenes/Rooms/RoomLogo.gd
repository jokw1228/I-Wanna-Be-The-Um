extends Node

@export var Logos_node: Node2D
@export var LogoSound_node: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	start_coroutine()

func start_coroutine():
	var from_color
	var to_color
	var duration
	var start_time
	
	LogoSound_node.play()
	
	await get_tree().create_timer(0.7).timeout
	
	from_color = Color(1, 1, 1, 0) # 처음 색상
	to_color = Color(1, 1, 1, 1)  # 변경하려는 색상
	duration = 2.0  # 색상 변경에 걸리는 시간
	start_time = Time.get_ticks_msec() / 1000.0

	while true:
		var elapsed = Time.get_ticks_msec() / 1000.0 - start_time
		var t = min(elapsed / duration, 1)
		Logos_node.modulate = lerp(from_color, to_color, t)
		
		if t >= 1:
			break
		await get_tree().process_frame
	
	Logos_node.modulate = to_color
	
	await get_tree().create_timer(1.4).timeout
	
	from_color = Color(1, 1, 1, 1) # 처음 색상
	to_color = Color(1, 1, 1, 0)  # 변경하려는 색상
	duration = 0.8  # 색상 변경에 걸리는 시간
	start_time = Time.get_ticks_msec() / 1000.0

	while true:
		var elapsed = Time.get_ticks_msec() / 1000.0 - start_time
		var t = min(elapsed / duration, 1)
		Logos_node.modulate = lerp(from_color, to_color, t)
		
		if t >= 1:
			break
		await get_tree().process_frame
	
	Logos_node.modulate = to_color
	
	await get_tree().create_timer(0.2).timeout
	RoomTransitionEffectManager.effecting(RoomTransitionEffectManager.type.up_to_down, 1)
	await RoomTransitionEffectManager.effecting_end
	get_tree().change_scene_to_file("res://Scenes/Rooms/RoomMainMenu.tscn")
	#await get_tree().create_timer(1.0).timeout
	#RoomTransitionEffectManager.effecting(RoomTransitionEffectManager.type.up_to_down, 0)
