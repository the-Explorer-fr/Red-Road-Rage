extends Marker2D

var speed: int = 0

func _process(delta):
	position.x -= speed * delta
	if position.x < 2700:
		position.x = 2700
		speed = 0
