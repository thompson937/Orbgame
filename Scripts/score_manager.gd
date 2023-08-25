extends Node2D

#Personal best:15755
#With controller:12475

var time = 0

var score = 0
@export var scorePerSeconds = 5
@export var missileBonus = 30

var parent
var player
var label

var previousScore = 0.0
var lerpedScore = 0.0

func _ready():
	parent = get_parent()
	label = parent.get_node("Player/HUD/Control/Label")
	player = parent.get_node("Player")


func _process(delta):
	time += delta
	var deltaScore = (score - previousScore)
	label.text = str(score)
	
	lerpedScore = lerpedScore + (deltaScore - lerpedScore) * 0.01
	
	label.scale.x = 1 + lerpedScore / 10
	label.scale.y = 1 + lerpedScore / 10
	
	previousScore = score

func start():
	score = 0
	previousScore = 0

func _on_score_seconds_timeout():
	score += scorePerSeconds * player.helf
	
func missile_boom():
	score += missileBonus
