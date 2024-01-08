extends Node


func save_game(save_room, save_position):
	var save_data = {
		"save_room" : save_room,
		"save_position" : save_position
	}
	var save_file = FileAccess.open("user://IWBTU_savefile.dat", FileAccess.WRITE)
	save_file.store_string(save_data)

func load_game():
	var load_file = FileAccess.open("user://IWBTU_savefile.dat", FileAccess.READ)
	var laod_data = load_file.get_file_as_text()
	var load_room
	var load_position
	get_tree().change_scene_to_file(load_room)
