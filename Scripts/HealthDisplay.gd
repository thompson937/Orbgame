extends Node2D

@export var healthOrb : PackedScene
var trackedOrbs = []

var prevFrameHealth = 0
	
func _process(delta):
	var deltaHealth = GameState.playerHealth - prevFrameHealth
	
	if deltaHealth > 0:
		reset_balls()
	
	# Failsafe in case balls don't exist
	
	if len(trackedOrbs) == 0:
		return
	
	if deltaHealth < 0:
		var orbToDestroy = trackedOrbs[len(trackedOrbs) - 1]
		
		if GameState.playerHealth > 3:
			trackedOrbs.pop_back()
		else:
			orbToDestroy = trackedOrbs[0]
			trackedOrbs.pop_front()
			
		orbToDestroy.queue_free()
	
	var wantedPosition = Vector2.ZERO
	
	for i in len(trackedOrbs):
		var hp = float(len(trackedOrbs))
		var spin = GameState.time * 4
		wantedPosition = Vector2(sin(spin + PI / hp * 2 * (i + 1)) * 40, cos(spin + PI / hp * 2 * (i + 1)) * 40)
			
		trackedOrbs[i].position.x = lerpf(trackedOrbs[i].position.x, wantedPosition.x, 0.1)
		trackedOrbs[i].position.y = lerpf(trackedOrbs[i].position.y, wantedPosition.y, 0.1)
		
		trackedOrbs[i].position = trackedOrbs[i].position.normalized() * 40
	
	prevFrameHealth = GameState.playerHealth

func reset_balls():
	#prevFrameHealth = GameState.playerHealth
	trackedOrbs.clear()
	for i in GameState.playerHealth:
		var instance = healthOrb.instantiate()
		trackedOrbs.append(instance)
		instance.position = Vector2.ZERO
		add_child(instance)
