extends Node2D

var rocket_scene: PackedScene = preload("res://scenes/items/rocket/rocket.tscn")
var shrink_scene: PackedScene = preload("res://scenes/items/shrink/shrink.tscn")
var tank_scene: PackedScene = preload("res://scenes/items/tank/tank.tscn")

func _process(_delta):
	power_out()

func _on_timer_timeout():
	$Timer.wait_time = 15.0 + randi() % 16
	var random = randi() % 100
	var power
	if random < 41:
		power = rocket_scene.instantiate()
		random = 0
	elif random < 71:
		power = shrink_scene.instantiate()
		random = 1
	else:
		power = tank_scene.instantiate()
		random = 2
	"""
	var random = randi() % 100
	var power
	if random == 0:
		power = rocket_scene.instantiate()
	elif random == 1:
		power = shrink_scene.instantiate()
	elif random == 2:
		power = tank_scene.instantiate()"""

	get_node("power_ups").add_child(power)
	generation_position_signal(power, random)

func generation_position_signal(body, type):
	body.position.x = 2300
	body.position.y = 350 + randi() % 560
	if type == 0:
		body.recolted.connect(_on_rocket_signal)
	elif type == 1:
		body.recolted.connect(_on_shrink_signal)
	elif type == 2:
		body.recolted.connect(_on_tank_signal)

func power_out():
	var powers = get_node("power_ups").get_children()
	for power in powers:
		if power.position.x < -100:
			power.queue_free()
			$Timer.start()

func collect(body):
	$AudioStreamPlayer.play()
	body.queue_free()
	$Timer.start()
	

func _on_rocket_signal(body):
	collect(body)
	if Globals.power_saved == -1:
		Globals.power_saved = 0

func _on_shrink_signal(body):
	collect(body)
	if Globals.power_saved == -1:
		Globals.power_saved = 1

func _on_tank_signal(body):
	collect(body)
	if Globals.power_saved == -1:
		Globals.power_saved = 2
