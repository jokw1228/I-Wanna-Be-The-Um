extends Node2D
class_name Spike

@export var Sprite2D_node: Sprite2D


func _on_killer_area_2d_killed_player():
	Sprite2D_node.modulate = Color(1, 0.8, 0.8, 1)
