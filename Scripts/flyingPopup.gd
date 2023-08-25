extends AnimatedSprite2D

var timer = 2.0


func _process(delta):
	position.y -= delta * 40
	timer -= delta
	
	if timer < 0:
		queue_free()
