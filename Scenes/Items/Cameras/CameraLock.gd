extends Camera2D

@export var RoomSize: Vector2

const width = 320
const height = 176

var position_state: Vector2
var position_maximum: Vector2

func _ready():
	position_state = position
	position_maximum.x = RoomSize.x - width
	position_maximum.y = RoomSize.y - height

func _process(_delta):
	var player = get_tree().get_nodes_in_group("Player")
	if player != []:
		var position_target: Vector2
		position_target.x = int(player[0].position.x / width) * width
		position_target.y = int(player[0].position.y / height) * height
		if position_state != position_target and not (position_target.x < 0 or position_target.x > position_maximum.x or position_target.y < 0 or position_maximum.y > position_maximum.y):
			position_state = position_target
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", position_target, 0.2).set_trans(Tween.TRANS_SINE)
