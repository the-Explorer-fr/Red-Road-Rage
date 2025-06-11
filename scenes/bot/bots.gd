extends Node2D

var list_pos_y = [915, 645, 375]
var pixel_betwen_lines = 270
var middle_line = true

func _process(delta):
	var bots = self.get_children()
	for bot in bots:
		move(bot, delta)
		if bot.overtake_direction == 0:
			need_overtake(bot)
		else:
			stop_overtake(bot, delta)
			
func move(body, delta):
	body.position.x -= body.speed * delta
	body.position.y += body.speed_vertical * body.overtake_direction * delta

func stop_overtake(body, delta):
	if body.overtake_direction == 1:
		if body.position.y + body.speed_vertical * delta > body.position_y_aim:
			body.position.y = body.position_y_aim
			body.overtake_direction = 0
			body.speed = body.speed_max
	else:
		if body.position.y - body.speed_vertical * delta < body.position_y_aim:
			body.position.y = body.position_y_aim
			body.overtake_direction = 0
			body.speed = body.speed_max

func recolt_collisions(body, area):
	var overlapping_areas = body.get_node(area).get_overlapping_areas()
	# Liste des entités dans la zone donnée
	var bots_in_area = []
	# Parcourir les zones chevauchantes pour obtenir les entités
	for overlapping_area in overlapping_areas:
		for node in overlapping_area.get_children():
			if node is CollisionPolygon2D:
				bots_in_area.append(overlapping_area.get_owner())
				break
	return bots_in_area

func block_middle_line_overtake():
	middle_line = false
	$"../Timer_middle_line".start()

func verification_overtake_side(body, bot):
	var delta_position = (bot.position.x + bot.get_node("back").position.x) - (body.position.x + body.get_node("front").position.x)
	if bot.speed <= 300:
		if delta_position > 350:
			return false
	elif bot.speed <= 550:
		if delta_position > 450:
			return false
	return true

func verification_overtake_front(body, bot):
	var delta_position = (bot.position.x + bot.get_node("back").position.x) - (body.position.x + body.get_node("front").position.x)
	if bot.speed <= 300 and delta_position > 400:
		return false
	elif bot.speed <= 550 and delta_position > 575:
		return false
	elif delta_position > 625:
		return false
	elif delta_position < 440 and bot.speed > 300:
		body.speed = bot.speed + 125
		return false
	elif delta_position < 200:
		body.speed = bot.speed + 125
		return false
	return true

# Fonction pour vérifier si quelque chose est dans une zone donnée
func need_overtake(body):
	# Récupérer les zones qui se chevauchent avec la zone donnée
	var bots_in_area = recolt_collisions(body, "Area2D_front")
	# Vérifier si des entités sont dans la zone donnée
	if bots_in_area.size() > 0:
		for bot in bots_in_area:
			if bot.speed > body.speed_max:
				if verification_overtake_front(body, bot):
					can_overtake(body, bot.speed)

func can_overtake_left(body):
	var bots_in_area = recolt_collisions(body, "Area2D_left")
	if bots_in_area.size() == 0:
		body.overtake_direction = -1
		body.position_y_aim -= 270
		body.speed = body.speed_max
		return true
	else:
		for bot in bots_in_area:
			if verification_overtake_side(body, bot):
				return false
		body.overtake_direction = -1
		body.position_y_aim -= 270
		body.speed = body.speed_max
		return true

func can_overtake_right(body):
	var bots_in_area = recolt_collisions(body, "Area2D_right")
	if bots_in_area.size() == 0:
		body.overtake_direction = 1
		body.position_y_aim += 270
		body.speed = body.speed_max
		return true
	else:
		for bot in bots_in_area:
			if verification_overtake_side(body, bot):
				return false
		body.overtake_direction = 1
		body.position_y_aim += 270
		body.speed = body.speed_max
		return true
		

func can_overtake(body, bot_overtake_speed: int):
	if body.position.y == list_pos_y[2]:
		if not middle_line or not can_overtake_right(body):
			body.speed = bot_overtake_speed
		else:
			block_middle_line_overtake()

	elif body.position.y == list_pos_y[1]:
		if not can_overtake_left(body):
			if not can_overtake_right(body):
				body.speed = bot_overtake_speed

	elif body.position.y == list_pos_y[0]:
		if not middle_line or not can_overtake_left(body):
			body.speed = bot_overtake_speed
		else:
			block_middle_line_overtake()
	else:
		body.speed = bot_overtake_speed


func _on_timer_middle_line_timeout():
	middle_line = true
