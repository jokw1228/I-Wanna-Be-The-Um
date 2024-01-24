extends Node

var Player_scene = load("res://Scenes/Player/Player.tscn")

var load_room
var load_position

const SAVE_PATH = "res://IWBTU_savefile.dat" #"user://IWBTU_savefile.dat"

func save_game(save_room, save_position):
	var save_data = {
		"save_room" : save_room,
		"save_position" : save_position
	}
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var jstr = JSON.stringify(save_data)
	save_file.store_line(jstr)

func load_game():
	var load_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not load_file:
		return
	if load_file == null:
		return
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not load_file.eof_reached():
			var current_line = JSON.parse_string(load_file.get_line())
			if current_line:
				load_room = current_line["save_room"]
				load_position = current_line["save_position"]
				
				load_room = "res://Scenes/Rooms/" + load_room + ".tscn"
				var split_string = load_position.replace("(", "").replace(")", "").split(",")
				load_position = Vector2(float(split_string[0]), float(split_string[1]))
				
				RoomTransitionManager.room_change(RoomTransitionEffectManager.type.up_to_down, 1, load_room, RoomTransitionEffectManager.type.up_to_down, 0)
