extends Area2D

var inputDirections = Vector2.ZERO
var lastInputs = Vector2.ZERO

@export var speed = 50

var immuneTime = 1.0
var dashTime = -10.0
@export var dashTimeOut = 4
var playedDashAnim = false
var playedDeathSound = false

func _process(delta):
	# Once GameState is finished this resets the player
	
	if GameState.resetComplete:
		GameState.resetComplete = false
		reset_player()
	
	# Death handling
	
	if GameState.gameOver and not playedDeathSound:
		playedDeathSound = true
		hide()
		$DeathSound.play()
	
	# Give player i-frames when paused
	
	if GameState.paused:
		immuneTime = 0.2
	
	inputDirections = Vector2.ZERO
	
	# Dash logic
	
	if dashTime > 0:
		inputDirections = lastInputs
		immuneTime = 0.1
	
	if not GameState.paused:
		dashTime -= delta
	
	# i-frame color changes
	
	if immuneTime > 0:
		immuneTime -= delta
		$Sprite2D.modulate = Color8(255, 255, 255, 100)
	else:
		$Sprite2D.modulate = Color8(255, 255, 255, 255)
	
	# Take in inputs
	
	if dashTime <= 0:
		inputDirections.y = Input.get_axis("move_up", "move_down")
		inputDirections.x = Input.get_axis("move_left", "move_right")

	inputDirections = inputDirections.normalized()
	
	if dashTime < -dashTimeOut && GameState.selectedPower == "dash":
		if not playedDashAnim:
			$DashParticle.emitting = true
			playedDashAnim = true
		
		if Input.is_action_just_pressed("dash"):
			playedDashAnim = false
			dashTime = 0.2
		
	lastInputs = inputDirections
	
	if Input.is_action_just_pressed("pause"):
		GameState.paused = not GameState.paused
	
	if Input.is_action_pressed("dash") && GameState.selectedPower == "time":
		GameState.timeScale = lerpf(GameState.timeScale, 0.5, 0.1)
	else:
		GameState.timeScale = lerpf(GameState.timeScale, 1, 0.1)
	
	# Apply gathered inputs
	
	if not GameState.paused:
		position += inputDirections * delta * (speed + (clamp(ceil(dashTime), 0, 1) * 500)) *  sqrt(GameState.timeScale)
		
	position.x = clampf(position.x, -1024 + 16, 1024 - 16)
	position.y = clampf(position.y, -1024 + 16, 1024 - 16)


func _on_area_entered(area):
	if area.is_in_group("missile") and immuneTime <= 0:
		immuneTime = 1
		GameState.playerHealth -= 1

func reset_player():
	immuneTime = 1.0
	dashTime = -10
	playedDashAnim = false
	playedDeathSound = false
	show()
	position = Vector2.ZERO
