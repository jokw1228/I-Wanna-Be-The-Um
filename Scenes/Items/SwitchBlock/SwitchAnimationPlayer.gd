extends AnimationPlayer

var switched: bool = false

func _on_switch_block_switched():
	if switched == false:
		switched = true
		play("move")
	elif switched == true:
		switched = false
		play_backwards("move")
