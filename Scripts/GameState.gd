extends Node

# Highscore: 13069

var playerHealth = 5
# dash, time
var selectedPower = "dash"
var score = 0
var missilePoints = 0
var time = 0

var waveActive : bool = true
var waveCount = 1
var waveAmount = 20

var waveSpawnTime = 1

var waveRest = 0

var timeScale = 1.0

var paused = false
var gameOver = false

var missileBonus = 30
var scoreMultiplier = 5
var scoreTime = 0

var resetComplete = false

func reset_game():
	paused = false
	gameOver = false
	playerHealth = 5
	time = 0
	score = 0
	missilePoints = 0
	randomize()
	resetComplete = true
	
	waveCount = 1
	waveAmount = 10
	waveActive = true
	waveRest = 0
	waveSpawnTime = 1

func _process(delta):
	if waveAmount <= 0 and waveActive:
		waveActive = false;
		print("Wave over!")
	
	if not waveActive and waveRest <= 0:
		waveRest = 5
	
	waveRest -= delta
	
	if waveRest < 0.2 and not waveActive:
		waveActive = true
		waveCount += 1
		waveAmount = 10 + 5 * waveCount
		waveSpawnTime /= 1.2
		
		if waveSpawnTime < 0.4:
			waveSpawnTime = 0.4
			
		print("Wave ", waveCount)
		print("Wave Amount: ", waveAmount)
		print("Wave Time: ", waveSpawnTime)
	
	if not paused:
		time += delta * timeScale
		if waveActive:
			scoreTime += delta * timeScale
		
		if time > 1:
			score = scoreTime * scoreMultiplier + missilePoints
			score = floor(score)
	
	if playerHealth <= 0:
		gameOver = true
	
	if timeScale > 0.9:
		AudioServer.set_bus_effect_enabled(1, 2, false)
	else:
		AudioServer.set_bus_effect_enabled(1, 2, true)

func missile_bonus():
	missilePoints += missileBonus
