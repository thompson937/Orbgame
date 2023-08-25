extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/VBoxContainer/EnterButton.grab_focus()
	AudioServer.set_bus_effect_enabled(1, 1, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enter_button_pressed():
	get_tree().change_scene_to_file("res://Nodes/main.tscn")
	GameState.reset_game()


func _on_quit_button_pressed():
	get_tree().quit()
