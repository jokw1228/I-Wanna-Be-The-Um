extends StaticBody2D

var hp = 10
@export var sprite: Sprite2D

@export var fragment_scene: PackedScene
@export var effect_scene: PackedScene


func _on_area_2d_area_entered(area):
	if area.is_in_group("PlayerBulletArea2D"):
		area.get_parent().destory_bullet()
		hp -= 1
		if hp > 0:
			sprite.modulate = Color(1, hp / 10.0, hp / 10.0, 1)
		else:
			for i in range(3):
				var inst = fragment_scene.instantiate()
				inst.position = position
				get_tree().current_scene.add_child(inst)
			CameraManager.apply_shake(0.5, 5)
			var inst2 = effect_scene.instantiate()
			inst2.position = position
			get_tree().current_scene.add_child(inst2)
			queue_free()
