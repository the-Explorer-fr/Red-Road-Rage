extends CharacterBody2D

var speed: int = 100 + randi() % 200
var speed_max = speed
var position_y_aim

var speed_vertical = 300

var overtake_direction: int = 0

func _ready():
	var sprites = get_node("Sprites").get_children()
	var random: int = randi() % sprites.size()
	for i in range(sprites.size()):
		if i != random:
			sprites[i].hide()
