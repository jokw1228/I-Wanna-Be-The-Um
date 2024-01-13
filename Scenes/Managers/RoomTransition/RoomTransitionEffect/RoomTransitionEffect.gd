extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fade_in():
	fade(Vector2(0, 0), Vector2(1, 1))

func fade_out():
	fade(Vector2(1, 1), Vector2(0, 0))

func fade(from_scale, to_scale):
	var duration = 0.6
	var start_time = Time.get_ticks_msec() / 1000.0
	
	scale = from_scale

	while true:
		var elapsed = Time.get_ticks_msec() / 1000.0 - start_time
		var t = min(elapsed / duration, 1)
		scale = lerp(from_scale, to_scale, t)
		
		if t >= 1:
			break
		await get_tree().process_frame
	
	scale = to_scale
