extends ColorRect

signal returnToGame()

var unHidden = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if unHidden:
		$ReturnButton.grab_focus()
		unHidden = false

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Nodes/main_menu.tscn")


func _on_return_button_pressed():
	emit_signal("returnToGame")


func _on_quit_button_pressed():
	get_tree().quit()

func _on_visible_on_screen_notifier_2d_screen_entered():
	unHidden = true
