extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fade_in():
	fade(Vector2(1, 1))

func fade_out():
	fade(Vector2(0, 0))

func fade(to_scale):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", to_scale, 0.6)
