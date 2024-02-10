extends Area2D
class_name KillerArea2D

signal killed_player

func _on_area_entered(area):
	if area.is_in_group("PlayerArea2D"):
		area.get_parent().kill_player()
		killed_player.emit()
