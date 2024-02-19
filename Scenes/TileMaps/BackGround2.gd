extends Node2D

@export var layer2: Sprite2D
@export var layer3: Sprite2D
@export var layer4: Sprite2D

var theta = 0

func _process(delta):
	theta += delta
	layer2.offset.y = sin(theta*1) * 0.5
	layer3.offset.y = sin(theta*2) * 1
	layer4.offset.y = sin(theta*3) * 1.5
