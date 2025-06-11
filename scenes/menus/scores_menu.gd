extends Control

func _ready():
	$back_main_menu_button.grab_focus()
	$music.play()
	load_data()

func load_data():
	var save_path = "res://elements/saves/score.save"
	#var save_path = "user://save_data.save"
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var score_data = file.get_var()
		var list_score_top = score_data["scores"]
		var list_name_top = score_data["names"]
		file.close()
		
		var i = 0
		var list_score = get_node("scores_container").get_children()
		for score in list_score:
			if list_score_top[i][0] > 9:
				score.text = str(list_score_top[i][1]) + " : " + str(list_score_top[i][0])
			else:
				score.text = str(list_score_top[i][1]) + " : 0" + str(list_score_top[i][0])
			i += 1
		var list_name = get_node("names_container").get_children()
		i = 0
		for name_score in list_name:
			name_score.text = char(list_name_top[i][0]) + char(list_name_top[i][1]) + char(list_name_top[i][2])
			i += 1


func _on_back_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
