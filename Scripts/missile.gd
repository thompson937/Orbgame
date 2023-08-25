extends Area2D

@export var timer = 3.0
@export var speed = 300.0
@export var turn_rate = 0.1

var orient = true

@export var explosionNode: PackedScene
@export var missileBonusNode : PackedScene

var player

func _process(delta):
	if GameState.gameOver:
		explode(false)
	
	if not GameState.paused:
		timer -= delta * GameState.timeScale
	
	var direction = player.position - position

	var desired_rotation = atan2(direction.y, direction.x)

	var rotation_diff = wrapf(desired_rotation - rotation, -PI, PI)
	
	if not orient:
		rotation_diff = clamp(rotation_diff, -turn_rate, turn_rate) * GameState.timeScale
	
	#Disable steering
	if timer >= 0 and not GameState.paused:
		rotation += rotation_diff
	
	var velocity = Vector2.RIGHT.rotated(rotation)
	
	if not GameState.paused:
		position += velocity * delta * speed * GameState.timeScale
	
	orient = false



func _on_visible_on_screen_notifier_2d_screen_exited():
	explode(true)


func _on_area_entered(area):
	if area.is_in_group("player"):
		explode(false)
	else:
		explode(true)
	
func explode(applyBonus : bool):
	if applyBonus:
		GameState.missile_bonus()
		var plus = missileBonusNode.instantiate()
		plus.position = position
		get_parent().add_child(plus)
	
	var boom = explosionNode.instantiate()
	boom.position = position
	get_parent().add_child(boom)
	queue_free()
