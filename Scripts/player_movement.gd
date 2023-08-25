extends Area2D

var inputDirections = Vector2.ZERO
var lastInputs = Vector2.ZERO

@export var speed = 50

var helf = 5
var ded = false
var paused = false

var immuneTime = 1.0
var dashTime = -10.0
@export var dashTimeOut = 4
var playedDashAnim = false

func _process(delta):
	
	if paused:
		immuneTime = 0.2
	
	inputDirections = Vector2.ZERO
	
	if dashTime > 0:
		inputDirections = lastInputs
		immuneTime = 0.1
	
	dashTime -= delta
	
	if immuneTime > 0:
		immuneTime -= delta
		$Sprite2D.modulate = Color8(255, 255, 255, 100)
	else:
		$Sprite2D.modulate = Color8(255, 255, 255, 255)
	
	var healthBar = $HUD/Control/ProgressBar.value
	
	$HUD/Control/ProgressBar.value = healthBar + (helf * 20 - healthBar) * 0.05
	
	
	if ded:
		if $HUD/Control/ProgressBar.value <= 0.1:
			$HUD/Control/ProgressBar.value = 0
		return
	
	if dashTime <= 0:
		inputDirections.y = Input.get_axis("move_up", "move_down")
		inputDirections.x = Input.get_axis("move_left", "move_right")

	inputDirections = inputDirections.normalized()
	
	if dashTime < -dashTimeOut:
		if not playedDashAnim:
			$DashParticle.emitting = true
			playedDashAnim = true
		
		if Input.is_action_just_pressed("dash"):
			playedDashAnim = false
			dashTime = 0.2
		
	lastInputs = inputDirections
	
	if not paused:
		position += inputDirections * delta * (speed + (clamp(ceil(dashTime), 0, 1) * 500))
		
	position.x = clampf(position.x, -1024 + 16, 1024 - 16)
	position.y = clampf(position.y, -1024 + 16, 1024 - 16)


func _on_area_entered(area):
	if area.is_in_group("missile") and immuneTime <= 0:
		immuneTime = 1
		helf -= 1
		print(helf)

func start():
	immuneTime = 1.0
	dashTime = -10
	playedDashAnim = false
	paused = false
	ded = false
	helf = 5
	show()
	position = Vector2.ZERO
	
func pause():
	paused = not paused

func ono_ded():
	hide()
	$AudioStreamPlayer.play()
	ded = true
	
