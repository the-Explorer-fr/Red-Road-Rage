extends Node2D

func _ready():
	$start.play()

func _on_player_player_dead():
	get_node("UI_in_game").save()
