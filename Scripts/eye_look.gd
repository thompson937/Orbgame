extends Sprite2D

var lerpedDir = Vector2.ZERO
@export var lookMultiplier = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var lookDir = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		lookDir.y = -1
	if Input.is_action_pressed("move_down"):
		lookDir.y = 1
	if Input.is_action_pressed("move_left"):
		lookDir.x = -1
	if Input.is_action_pressed("move_right"):
		lookDir.x = 1
	
	lookDir = lookDir.normalized()
	
	lerpedDir.x = lerpedDir.x + (lookDir.x - lerpedDir.x) * 0.15
	lerpedDir.y = lerpedDir.y + (lookDir.y - lerpedDir.y) * 0.15
	
	position = lerpedDir * lookMultiplier
