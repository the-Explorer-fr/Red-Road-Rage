extends Node2D


func _ready():
	var sprites = get_children()
	var random: int = randi() % sprites.size()
	for i in range(sprites.size()):
		if i != random:
			sprites[i].hide()
