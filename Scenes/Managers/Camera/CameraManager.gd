extends Node

var camera: Camera2D

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var shake_fade: float = 5.0

func apply_shake(strength: float, fade: float):
	shake_strength = strength
	shake_fade = fade

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

func _process(delta):
	var camera_list = get_tree().get_nodes_in_group("Camera")
	if camera_list != []:
		camera = camera_list[0]
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		camera.offset = random_offset()
