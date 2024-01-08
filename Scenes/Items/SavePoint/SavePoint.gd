extends Area2D

@export var SavePointSprite_node: Sprite2D
@export var CircleSprite_node: AnimatedSprite2D

#@export var SavePointSaved_scene: PackedScene
var SavePointSaved_scene = load("res://Scenes/Items/SavePoint/SavePointSaved.tscn")

var theta = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	CircleSprite_node.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	theta += delta * 2
	SavePointSprite_node.position.y = sin(theta)


func _on_area_entered(area):
	if area.is_in_group("PlayerArea2D"):
		var inst = SavePointSaved_scene.instantiate()
		inst.position = position
		get_tree().current_scene.add_child.call_deferred(inst)
		queue_free()
