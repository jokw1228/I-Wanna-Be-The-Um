extends StaticBody2D

@export var EffectGenerator_scene: PackedScene
@export var Sprite_node: AnimatedSprite2D
@export var Timer_node: Timer

signal switched()

# Called when the node enters the scene tree for the first time.
func _ready():
	Sprite_node.play()


func _on_area_2d_area_entered(area):
	if area.is_in_group("PlayerBulletArea2D"):
		switched.emit()
		area.get_parent().destory_bullet()
		
		var inst = EffectGenerator_scene.instantiate()
		inst.position = position
		get_tree().current_scene.add_child(inst)
		
		Timer_node.start()
		if Sprite_node.animation == "idle":
			Sprite_node.animation = "light_on"


func _on_timer_timeout():
	Sprite_node.animation = "idle"
