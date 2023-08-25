extends Node

var playerHealth = 5
var score = 0
var missilePoints = 0
var time = 0

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
		time += delta
		if time > 1:
			score = floor(time * scoreMultiplier) + missilePoints
			score = floor(score)
	
	if playerHealth <= 0:
		gameOver = true

func missile_bonus():
	missilePoints += missileBonus
