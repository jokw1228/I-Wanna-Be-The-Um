extends TextureProgressBar


func update(hp: float, hp_max: float):
	value = hp / hp_max * 100
