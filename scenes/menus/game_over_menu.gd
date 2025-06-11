extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer2/restart_button.grab_focus()
	$loose.play()


func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main/level.tscn")


func _on_back_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
