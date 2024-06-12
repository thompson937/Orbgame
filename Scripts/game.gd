extends Node2D

@export var missileAsset : PackedScene
@export var waveObject : PackedScene

func _process(delta):
	$RocketSpawner.wait_time = GameState.waveSpawnTime / GameState.timeScale
	
	if GameState.gameOver:
		GameState.paused = true
		$RocketSpawner.stop()
	elif GameState.resetComplete:
		$RocketSpawner.start()
	
	if GameState.sendMessage != "":
		print(GameState.sendMessage)
		var waveInstance = waveObject.instantiate()
		
		waveInstance.position = $Player.global_position
		add_child(waveInstance)
		GameState.sendMessage = ""
	

func _on_missile_spawner_timeout():
	if GameState.paused:
		return
	
	if not GameState.waveActive:
		return
	
	var missile = missileAsset.instantiate()
	missile.player = $Player
	var spawnPos = Vector2.ZERO
	
	var cam = $Camera2D.position
	
	var scrn = get_viewport().size / 1.8
	var wall = randi_range(0, 1)
	
	#if wall == 0:
	#	spawnPos.y = scrn.y
	#	spawnPos.x = randf_range(-scrn.x, scrn.x)
	
	if wall == 0:
		spawnPos.x = scrn.x
		spawnPos.y = randf_range(-scrn.y, scrn.y)
	
	#if wall == 1:
	#	spawnPos.y = -scrn.y
	#	spawnPos.x = randf_range(-scrn.x, scrn.x)
	
	if wall == 1:
		spawnPos.x = -scrn.x
		spawnPos.y = randf_range(-scrn.y, scrn.y)
	
	spawnPos.x += cam.x
	spawnPos.y += cam.y
	
	missile.position = spawnPos
	add_child(missile)
