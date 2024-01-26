extends Camera2D


func _process(_delta):
	var player = get_tree().get_nodes_in_group("Player")
	if player != []:
		position = player[0].position
