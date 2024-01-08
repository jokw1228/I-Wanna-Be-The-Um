extends Node2D

@export var SavePoint_node: Sprite2D

#@export var SavePoint_scene: PackedScene
var SavePoint_scene = load("res://Scenes/Items/SavePoint/SavePoint.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(5):
		SavePoint_node.modulate = Color(0.5, 0.5, 0.5, 1)
		await get_tree().create_timer(0.1).timeout
		SavePoint_node.modulate = Color(1, 1, 1, 1)
		await get_tree().create_timer(0.1).timeout
	var inst = SavePoint_scene.instantiate()
	inst.position = position
	get_tree().current_scene.add_child.call_deferred(inst)
	queue_free()
