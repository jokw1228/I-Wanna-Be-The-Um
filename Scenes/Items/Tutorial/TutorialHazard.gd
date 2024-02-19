extends Area2D

@export var rock: PackedScene
@export var sound: AudioStream

func _on_area_entered(area):
	if area.is_in_group("PlayerArea2D"):
		SoundManager.play_sound(sound, "SFX")
		var inst = rock.instantiate()
		inst.position = Vector2(position.x + 64, -32)
		get_tree().current_scene.add_child(inst)
		queue_free()
