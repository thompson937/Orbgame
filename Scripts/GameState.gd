extends Node

var playerHealth = 5
var selectedPower = "time"
var score = 0
var missilePoints = 0
var time = 0

var timeScale = 1.0

var paused = false
var gameOver = false

var missileBonus = 30
var scoreMultiplier = 5

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

func _process(delta):
	if not paused:
		time += delta * timeScale
		if time > 1:
			score = time * scoreMultiplier + missilePoints
			score = floor(score)
	
	if playerHealth <= 0:
		gameOver = true
	
	if timeScale > 0.8:
		AudioServer.set_bus_effect_enabled(1, 2, false)
	else:
		AudioServer.set_bus_effect_enabled(1, 2, true)

func missile_bonus():
	missilePoints += missileBonus
