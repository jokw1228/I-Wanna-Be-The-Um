extends Node

@export var KoreaUniv_node: Sprite2D
@export var CATandDOG_node: Sprite2D
@export var Label_node: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	start_coroutine()

func start_coroutine():
	var from_color = Color(1, 1, 1, 0) # 처음 색상
	var to_color = Color(1, 1, 1, 1)  # 변경하려는 색상
	var duration = 2.0  # 색상 변경에 걸리는 시간
	var start_time = Time.get_ticks_msec() / 1000.0

	while true:
		var elapsed = Time.get_ticks_msec() / 1000.0 - start_time
		var t = min(elapsed / duration, 1)
		KoreaUniv_node.modulate = lerp(from_color, to_color, t)
		CATandDOG_node.modulate = lerp(from_color, to_color, t)
		Label_node.modulate = lerp(from_color, to_color, t)
		
		if t >= 1:
			break
		await get_tree().process_frame
	
	KoreaUniv_node.modulate = to_color
	CATandDOG_node.modulate = to_color  # 마지막으로 색상 고정
	Label_node.modulate = to_color
	
	await get_tree().create_timer(2.0).timeout
	
	from_color = Color(1, 1, 1, 1) # 처음 색상
	to_color = Color(1, 1, 1, 0)  # 변경하려는 색상
	duration = 2.0  # 색상 변경에 걸리는 시간
	start_time = Time.get_ticks_msec() / 1000.0

	while true:
		var elapsed = Time.get_ticks_msec() / 1000.0 - start_time
		var t = min(elapsed / duration, 1)
		KoreaUniv_node.modulate = lerp(from_color, to_color, t)
		CATandDOG_node.modulate = lerp(from_color, to_color, t)
		Label_node.modulate = lerp(from_color, to_color, t)
		
		if t >= 1:
			break
		await get_tree().process_frame
	
	KoreaUniv_node.modulate = to_color
	CATandDOG_node.modulate = to_color  # 마지막으로 색상 고정
	Label_node.modulate = to_color
