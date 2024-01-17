extends Node2D

var position_original
@export var position_offset: Vector2 = Vector2(0, 0)
@export var delay: float = 0.25

var tween

var switched: bool = false

func _ready():
	position_original = position

func _on_switch_block_switched():
	if switched == false:
		switched = true
		tween = get_tree().create_tween()
		tween.tween_property(self, "position", position_original + position_offset, delay)
	elif switched == true:
		switched = false
		tween = get_tree().create_tween()
		tween.tween_property(self, "position", position_original, delay)
