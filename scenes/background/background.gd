extends Node2D

@export var line_speed = 1200

@onready var lines = get_node("little lines").get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for line in lines:
		line.position.x -= line_speed * delta
		if line.position.x <= -320:
			line.position.x = 1920
