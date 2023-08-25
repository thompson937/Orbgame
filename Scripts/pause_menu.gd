extends ColorRect

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Nodes/main_menu.tscn")

func _on_return_button_pressed():
	if not GameState.gameOver:
		GameState.paused = false
	else:
		GameState.reset_game()

func _on_quit_button_pressed():
	get_tree().quit()

