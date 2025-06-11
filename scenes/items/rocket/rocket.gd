extends Area2D

signal recolted(body)

var speed: int = 900

func _process(delta):
	position.x -= speed * delta
	get_node("light").rotation += 40 * delta


func _on_body_entered(_body):
	recolted.emit(self)
