extends Node2D

@export var missileAsset : PackedScene
var gameRunning = true
var gamePaused = false

var pauseScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	pauseScreen = $Player/HUD/Control/PauseScreen
	pauseScreen.hide()
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		gamePaused = not gamePaused
		pause_game()
	
	if $Player.helf <= 0 and gameRunning:
		end_game()

func new_game():
	pauseScreen.hide()
	gameRunning = true
	$Player.start()
	$RocketSpawner.start()
	$Score.start()
	$ScoreSeconds.start()
	AudioServer.set_bus_effect_enabled(1, 1, false)

func end_game():
	pauseScreen.show()
	gameRunning = false
	$RocketSpawner.stop()
	$ScoreSeconds.stop()
	print("Dead")
	var childrenToExplode = get_children()
	
	for child in childrenToExplode:
		if "Missile" in child.name:
			child.explode()
			
	$Player.ono_ded()
	AudioServer.set_bus_effect_enabled(1, 1, true)

func pause_game():
	if gamePaused:
		pauseScreen.show()
		AudioServer.set_bus_effect_enabled(1, 1, true)
		$RocketSpawner.stop()
		$ScoreSeconds.stop()
	else:
		pauseScreen.hide()
		AudioServer.set_bus_effect_enabled(1, 1, false)
		$RocketSpawner.start()
		$ScoreSeconds.start()
		
	$Player.pause()
	
	var children = get_children()
	
	for child in children:
		if "Missile" in child.name:
			child.paused = gamePaused

func _on_missile_spawner_timeout():
	var missile = missileAsset.instantiate()
	missile.player = $Player
	var spawnPos = Vector2.ZERO
	
	var cam = $Camera2D.position
	
	var scrn = get_viewport().size / 1.8
	var wall = randi_range(0, 3)
	
	if wall == 0:
		spawnPos.y = scrn.y
		spawnPos.x = randf_range(-scrn.x, scrn.x)
	
	if wall == 1:
		spawnPos.x = scrn.x
		spawnPos.y = randf_range(-scrn.y, scrn.y)
	
	if wall == 2:
		spawnPos.y = -scrn.y
		spawnPos.x = randf_range(-scrn.x, scrn.x)
	
	if wall == 3:
		spawnPos.x = -scrn.x
		spawnPos.y = randf_range(-scrn.y, scrn.y)
	
	spawnPos.x += cam.x
	spawnPos.y += cam.y
	
	missile.position = spawnPos
	add_child(missile)


func _on_pause_screen_return_to_game():
	if gameRunning:
		gamePaused = false
		pause_game()
	else:
		new_game()
