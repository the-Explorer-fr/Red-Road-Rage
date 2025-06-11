extends Control

func _ready():
	$VBoxContainer2/start_button.grab_focus()
	$music.play()

func _on_start_button_pressed():
	$music.stop()
	get_tree().change_scene_to_file.bind("res://scenes/main/level.tscn").call_deferred()

func _on_score_menu_button_pressed():
	get_tree().change_scene_to_file.bind("res://scenes/menus/scores_menu.tscn").call_deferred()

func _on_quit_button_pressed():
	get_tree().quit()
