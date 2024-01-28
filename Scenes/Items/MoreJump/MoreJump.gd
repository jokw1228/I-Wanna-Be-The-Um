extends Area2D

@export var sprite: Sprite2D
@export var effect: PackedScene

var theta = 0

func _process(delta):
	theta += delta * 2
	sprite.position.y = sin(theta) / 2

func _on_area_entered(area):
	if area.is_in_group("PlayerArea2D"):
		var player = get_tree().get_nodes_in_group("Player")
		if player != []:
			player[0].jumps_left = 1
			var inst = effect.instantiate()
			inst.position = position
			get_tree().current_scene.add_child(inst)
			queue_free()
