extends Node

var time_gameplay = [0, 0]

var position_player: Vector2 = Vector2(0, 0)

var score_name = "nul"

var power_saved = -1
var power_used: bool = false

func timer_start():
	$Timer_reset_global_item.start()


func _on_timer_reset_global_item_timeout():
	power_saved = -1
	power_used = false
