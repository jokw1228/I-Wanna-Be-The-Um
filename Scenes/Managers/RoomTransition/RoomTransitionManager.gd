extends Node2D


func room_change(effect1: RoomTransitionEffectManager.type, is_fade_in_1: bool, room_to_go: PackedScene, effect2: RoomTransitionEffectManager.type, is_fade_in_2: bool):
	RoomTransitionEffectManager.effecting(effect1, is_fade_in_1)
	await RoomTransitionEffectManager.effecting_end
	get_tree().change_scene_to_packed(room_to_go)
	RoomTransitionEffectManager.effecting(effect2, is_fade_in_2)
