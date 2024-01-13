extends Node2D

var Effect_scene = load("res://Scenes/Managers/RoomTransitionEffect/RoomTransitionEffect.tscn")
var effects = []
var size = 16
var x_num = 320 / size + 1
var y_num = 180 / size + 1

enum type {left_to_right, right_to_left, up_to_down, down_to_up}

func _ready():
	effect_ready()
	#effecting(type.up_to_down, 0)

func effect_ready():
	for y in range(y_num):
		effects.append([])
		for x in range(x_num):
			var inst = Effect_scene.instantiate()
			inst.position = Vector2(x * size, y * size)
			add_child(inst)
			effects[y].append(inst)

func effecting(from_to: type, is_fade_in: bool):
	
	var delay = 0.06
	
	if from_to == type.left_to_right or from_to == type.right_to_left:
		
		var a_list
		var b_list
		
		if from_to == type.left_to_right:
			a_list = range(x_num)
			b_list = range(y_num)
		elif from_to == type.right_to_left:
			a_list = range(x_num)
			a_list.reverse()
			b_list = range(y_num)
		
		for a in a_list:
			for b in b_list:
				if is_fade_in:
					effects[b][a].fade_in()
				else:
					effects[b][a].fade_out()
			await get_tree().create_timer(delay).timeout
		
	elif from_to == type.up_to_down or from_to == type.down_to_up:
		
		var a_list
		var b_list
		
		if from_to == type.up_to_down:
			a_list = range(y_num)
			b_list = range(x_num)
		elif from_to == type.down_to_up:
			a_list = range(y_num)
			a_list.reverse()
			b_list = range(x_num)
			
		for a in a_list:
			for b in b_list:
				if is_fade_in:
					effects[a][b].fade_in()
				else:
					effects[a][b].fade_out()
			await get_tree().create_timer(delay).timeout
