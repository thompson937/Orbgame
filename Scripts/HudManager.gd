extends Control

var prevScore = 0
var lerpedScore = 0

var intensity = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var deltaScore = GameState.score - prevScore
	lerpedScore = lerpf(lerpedScore, GameState.score, 0.2)
	lerpedScore = floor(lerpedScore)
	$ScoreLabel.text = str(lerpedScore)
	$ScoreLabel.rotation = sin(GameState.time * 60) / 700 * intensity
	var scoreScale = lerpf(1, 1.5, intensity / 100)
	$ScoreLabel.scale = Vector2(scoreScale, scoreScale)
	$Healthbar.value = GameState.playerHealth * 20
	
	intensity += deltaScore
	intensity -= 1
	intensity = clamp(intensity, 1, 100)
	
	if GameState.paused:
		$PauseScreen.show()
		AudioServer.set_bus_effect_enabled(1, 1, true)
	else:
		$PauseScreen.hide()
		AudioServer.set_bus_effect_enabled(1, 1, false)
	
	prevScore = GameState.score

