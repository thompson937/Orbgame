extends Control

var timer = 0
var flash = false
var destruct = 30

func _ready():
	$RichTextLabel.text = "[center]" + GameState.sendMessage


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	timer += delta
	if timer > 0.1:
		flash = not flash
		timer = 0
		destruct -= 1
	
	if flash:
		$RichTextLabel.modulate = Color8(100, 100, 100, 255)
	else:
		$RichTextLabel.modulate = Color8(255, 255, 255, 255)
	
	position.y += -0.2
	
	if destruct <= 0:
		queue_free()

