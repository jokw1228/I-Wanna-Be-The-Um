extends Area2D

@export var CollisionShape2D_node: CollisionShape2D
@export var SavePointSprite_node: Sprite2D
@export var CircleSprite_node: AnimatedSprite2D
@export var Audio: AudioStream


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
		_saved()
		
func _saved():
	SaveFileManager.save_game(get_tree().current_scene.name, position)
	SoundManager.play_sound(Audio, "SFX")
	CollisionShape2D_node.set_deferred("disabled", true)
	for i in range(5):
		SavePointSprite_node.modulate = Color(0.5, 0.5, 0.5, 1)
		await get_tree().create_timer(0.1).timeout
		SavePointSprite_node.modulate = Color(1, 1, 1, 1)
		await get_tree().create_timer(0.1).timeout
	CollisionShape2D_node.set_deferred("disabled", false)
