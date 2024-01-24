extends Area2D

@export var effect1: RoomTransitionEffectManager.type
@export var RoomToGo_room: PackedScene
@export var effect2: RoomTransitionEffectManager.type

func _on_area_entered(area):
	if area.is_in_group("PlayerArea2D"):
		get_tree().call_group("Player", "queue_free")
		RoomTransitionManager.room_change(effect1, 1, RoomToGo_room, effect2, 0)

