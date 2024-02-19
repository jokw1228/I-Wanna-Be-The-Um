extends Node

@export var bgm: AudioStream

func _ready():
	SoundManager.play_music(bgm, 0.5, "BGM")
