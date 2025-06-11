extends Control

var time_gameplay = [0, 0]
var timer_run: bool = true

func _ready():
	Globals.power_saved = -1
	Globals.power_used = false
	$Timer_time.start()

func _process(_delta):
	power_up()

func save():
	var save_path = "res://elements/saves/score.save"
	#var save_path = "user://save_data.save"
	var file
	Globals.time_gameplay = time_gameplay
	if FileAccess.file_exists(save_path):
		file = FileAccess.open(save_path, FileAccess.READ)
		var score_data = file.get_var()
		file.close()
		var list_score_top = score_data["scores"]
		var score = list_score_top[9]
		if score[1] > time_gameplay[1] or (score[1] == time_gameplay[1] and score[0] > time_gameplay[0]):
			get_tree().change_scene_to_file.bind("res://scenes/menus/game_over_menu.tscn").call_deferred()
		else:
			get_tree().change_scene_to_file.bind("res://scenes/menus/new_high_score.tscn").call_deferred()

	else:
		get_tree().change_scene_to_file.bind("res://scenes/menus/new_high_score.tscn").call_deferred()

func modify_time_label():
	if time_gameplay[0] > 9:
		$VBoxContainer/time_data_label.text = str(time_gameplay[1]) + " : " + str(time_gameplay[0])
	else:
		$VBoxContainer/time_data_label.text = str(time_gameplay[1]) + " : 0" + str(time_gameplay[0])

func _on_timer_time_timeout():
	if timer_run:
		time_gameplay[0] += 1
		if time_gameplay[0] == 60:
			time_gameplay[1] += 1
			time_gameplay[0] = 0
		modify_time_label()

func _on_player_stop_timer():
	timer_run = false

func power_up():
	if Globals.power_used:
		if Globals.power_saved != -1:
			var sprites =  get_node("power_up/sprites").get_children()
			sprites[Globals.power_saved].hide()
	elif Globals.power_saved == 0:
		get_node("power_up/sprites/rocket").show()
	elif Globals.power_saved == 1:
		get_node("power_up/sprites/shrink").show()
	elif Globals.power_saved == 2:
		get_node("power_up/sprites/tank").show()
