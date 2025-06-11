extends Node2D

@onready var markers = self.get_children()

func collision():
	var bots = self.get_owner().get_node("bots_car").get_children()
	for bot in bots:
		if bot.position.x > 1920:
			for marker in markers:
				if marker.position.y == bot.position_y_aim:
					if -890 < marker.position.x - bot.position.x and marker.position.x - bot.position.x < 890:
						marker.position.x += 900
					while -890 < marker.position.x - bot.position.x and marker.position.x - bot.position.x < 890:
						marker.position.x += 200
