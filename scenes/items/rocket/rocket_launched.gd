extends Area2D

signal hit(body)

var speed = 400
var acceleration: int = 3000

func _ready():
	position = Globals.position_player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
	speed += acceleration * delta

func _on_body_entered(body):
	hit.emit(body)
	self.queue_free()
	body.queue_free()
