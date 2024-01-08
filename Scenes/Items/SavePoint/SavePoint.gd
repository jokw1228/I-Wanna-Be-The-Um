extends Area2D

@export var SavePointSprite_node: Sprite2D
@export var CircleSprite_node: AnimatedSprite2D

var theta = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	CircleSprite_node.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	theta += delta * 2
	SavePointSprite_node.position.y = sin(theta)
	pass
