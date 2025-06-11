extends Control

var letters = [65, 65, 65]
var rect_letter_selected_x = [500, 810, 1125, 1450]
var position_letter_selected = 0

func _ready():
	$sound.play()
	if Globals.time_gameplay[0] > 9:
		$VBoxContainer/time_data_label.text = str(Globals.time_gameplay[1]) + " : " + str(Globals.time_gameplay[0])
	else:
		$VBoxContainer/time_data_label.text = str(Globals.time_gameplay[1]) + " : 0" + str(Globals.time_gameplay[0])

func _on_sound_finished():
	$music.play()

func _process(_delta):
	inputs_letters()

func save():
	var time_gameplay = Globals.time_gameplay
	var save_path = "res://elements/saves/score.save"
	#var save_path = "user://save_data.save"
	var file
	if FileAccess.file_exists(save_path):
		file = FileAccess.open(save_path, FileAccess.READ)
		var score_data = file.get_var()
		var list_score_top = score_data["scores"]
		var list_name_top = score_data["names"]
		var i = 0
		for score in list_score_top:
			if score[1] < time_gameplay[1] or (score[1] == time_gameplay[1] and score[0] < time_gameplay[0]):
				var data_time = time_gameplay
				var data_name = letters
				for j in range (i, 10):
					var temp_time = list_score_top[j]
					list_score_top[j] = data_time
					data_time = temp_time
					var temp_name = list_name_top[j]
					list_name_top[j] = data_name
					data_name = temp_name
				break
			i += 1
		file.close()
		score_data["scores"] = list_score_top
		file = FileAccess.open(save_path, FileAccess.WRITE)
		file.store_var(score_data)

	else:
		var list_score_top = [time_gameplay, [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]
		var list_score_top_name = [letters, [65, 65, 65], [65, 65, 65], [65, 65, 65], [65, 65, 65], [65, 65, 65], [65, 65, 65], [65, 65, 65], [65, 65, 65], [65, 65, 65]]
		var score_data = {
			"scores": list_score_top,
			"names": list_score_top_name,
		}
		file = FileAccess.open(save_path, FileAccess.WRITE)
		file.store_var(score_data)

	file.close()

func update_letters():
	var letter
	if position_letter_selected == 0:
		letter = get_node("recolt_name_container/reclot_letter_container/letter")
	if position_letter_selected == 1:
		letter = get_node("recolt_name_container/reclot_letter_container2/letter")
	if position_letter_selected == 2:
		letter = get_node("recolt_name_container/reclot_letter_container3/letter")
	letter.text = char(letters[position_letter_selected])

func increase_letter():
	letters[position_letter_selected] += 1
	if letters[position_letter_selected] > 90:
		letters[position_letter_selected] = 65
	update_letters()

func decrease_letter():
	letters[position_letter_selected] -= 1
	if letters[position_letter_selected] < 65:
		letters[position_letter_selected] = 90
	update_letters()

func inputs_letters():
	if Input.is_action_just_pressed("down") and position_letter_selected != 3:
		increase_letter()

	if Input.is_action_just_pressed("up") and position_letter_selected != 3:
		decrease_letter()

	if Input.is_action_just_pressed("left"):
		if position_letter_selected > 0:
			position_letter_selected -= 1
			$letter_selected_rect.position.x = rect_letter_selected_x[position_letter_selected]

	if Input.is_action_just_pressed("right"):
		if position_letter_selected < 3:
			position_letter_selected += 1
			$letter_selected_rect.position.x = rect_letter_selected_x[position_letter_selected]
	
	if Input.is_action_just_pressed("enter"):
		save()
		get_tree().change_scene_to_file.bind("res://scenes/menus/main_menu.tscn").call_deferred()

func _on_up_button_pressed():
	position_letter_selected = 0
	$letter_selected_rect.position.x = rect_letter_selected_x[position_letter_selected]
	decrease_letter()


func _on_down_button_pressed():
	position_letter_selected = 0
	$letter_selected_rect.position.x = rect_letter_selected_x[position_letter_selected]
	increase_letter()


func _on_up_button_2_pressed():
	position_letter_selected = 1
	$letter_selected_rect.position.x = rect_letter_selected_x[position_letter_selected]
	decrease_letter()


func _on_down_button_2_pressed():
	position_letter_selected = 1
	$letter_selected_rect.position.x = rect_letter_selected_x[position_letter_selected]
	increase_letter()


func _on_up_button_3_pressed():
	position_letter_selected = 2
	$letter_selected_rect.position.x = rect_letter_selected_x[position_letter_selected]
	decrease_letter()


func _on_down_button_3_pressed():
	position_letter_selected = 2
	$letter_selected_rect.position.x = rect_letter_selected_x[position_letter_selected]
	increase_letter()


func _on_check_pressed():
	save()
	get_tree().change_scene_to_file.bind("res://scenes/menus/main_menu.tscn").call_deferred()
