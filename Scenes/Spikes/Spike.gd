extends Area2D
class_name Spike

@export var Sprite2D_node: Sprite2D

func _on_area_entered(area):
	if area.is_in_group("PlayerArea2D"):
		get_tree().call_group("Player", "kill_player")
		Sprite2D_node.modulate = Color(1, 0.8, 0.8, 1)
