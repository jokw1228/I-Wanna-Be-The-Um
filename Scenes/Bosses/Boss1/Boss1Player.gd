extends Area2D

@export var sprite_node: Sprite2D

@export var boss_scene: PackedScene
@export var hpbar_scene: PackedScene

@export var savepoint: Node

var theta = 0

func _process(delta):
	theta += delta * 2
	sprite_node.position.y = sin(theta)


func _on_area_entered(area):
	if area.is_in_group("PlayerArea2D"):
		var boss = boss_scene.instantiate()
		boss.position = Vector2(-32, -32)
		get_tree().current_scene.add_child(boss)
		
		var hpbar = hpbar_scene.instantiate()
		get_tree().current_scene.add_child(hpbar)
		
		boss.hp_changed.connect(hpbar.get_child(0).update)
		
		savepoint.queue_free()
		queue_free()
