extends CharacterBody2D

var speed: int = 200 + randi() % 250
var speed_max: int = speed
var sprite: int
@onready var sprites = get_node("Sprites").get_children()

func _ready():
	position.x = 2500
	sprite = randi() % sprites.size()
	for i in range(sprites.size()):
		if i != sprite:
			sprites[i].hide()
	
func _process(delta):
	move_bot(delta)
	bot_out()

func move_bot(delta):
	position.x -= speed * delta

func bot_out():
	if position.x < -800:
		sprites[sprite].hide()
		sprite = randi() % sprites.size()
		sprites[sprite].show()
		position.x = 4000 + randi() % 7000
