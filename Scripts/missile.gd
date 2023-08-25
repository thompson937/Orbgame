extends Area2D

@export var timer = 5.0
@export var speed = 300.0
@export var turn_rate = 0.1

@export var explosionNode: PackedScene

var maxTimer = 5.0

var player

func _ready():
	maxTimer = timer


func _process(delta):
	if GameState.gameOver:
		explode()
	
	if GameState.paused:
		timer -= delta
	
	var direction = player.position - position

	var desired_rotation = atan2(direction.y, direction.x)

	var rotation_diff = wrapf(desired_rotation - rotation, -PI, PI)

	rotation_diff = clamp(rotation_diff, -turn_rate, turn_rate)
	
	#Disable steering
	if timer >= 0 and not GameState.paused:
		rotation += rotation_diff
	
	var velocity = Vector2.RIGHT.rotated(rotation)
	
	if not GameState.paused:
		position += velocity * delta * speed



func _on_visible_on_screen_notifier_2d_screen_exited():
	explode()


func _on_area_entered(area):
	explode()
	
func explode():
	GameState.missile_bonus()
	var boom = explosionNode.instantiate()
	boom.position = position
	get_parent().add_child(boom)
	queue_free()
