extends GPUParticles2D

var timer = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	$PointLight2D.energy = pow(timer, 4)
	
	if timer <= 0:
		queue_free()
