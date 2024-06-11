extends Camera2D

@export var sensitivity = 1

var sharpPos = Vector2.ZERO

var zoomLevel = 1.5

func _process(delta):
	var player = get_node("/root/Main/Player").position
	var screenSize = get_viewport_rect().size
	
	var screenEdges = Vector2.ZERO
	screenEdges.x = (1024 - screenSize.x / 2 / zoom.x)
	screenEdges.y = (1024 - screenSize.y / 2 / zoom.y)
	
	var timeScaleZoom = lerpf(1.5, 1, GameState.timeScale)
	
	zoom.x = screenSize.x / 1024 / 1.5 * timeScaleZoom * zoomLevel
	zoom.y = screenSize.x / 1024 / 1.5 * timeScaleZoom * zoomLevel
	
	sharpPos = player
	
	sharpPos.x = clampf(sharpPos.x, -screenEdges.x, screenEdges.x)
	sharpPos.y = clampf(sharpPos.y, -screenEdges.y, screenEdges.y)
	
	position = position + (sharpPos - position) * 0.05
	#position.x = clampf(position.x, -screenEdges.x, screenEdges.x)
	#position.y = clampf(position.y, -screenEdges.y, screenEdges.y)
