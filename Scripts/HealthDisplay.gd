extends Node2D

@export var healthOrb : PackedScene
var trackedOrbs = []

var prevFrameHealth = 0

var ballsMoving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	prevFrameHealth = GameState.playerHealth
	for i in GameState.playerHealth:
		var instance = healthOrb.instantiate()
		trackedOrbs.append(instance)
		instance.position = Vector2.ZERO
		add_child(instance)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("restart"):
		GameState.playerHealth -= 1
	
	var deltaHealth = GameState.playerHealth - prevFrameHealth
	if deltaHealth != 0:
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
		#trackedOrbs[i].position.x *= 40
		#trackedOrbs[i].position.y *= 40
	
	prevFrameHealth = GameState.playerHealth
