extends Area2D

@export var timer = 5.0
@export var speed = 300.0
@export var turn_rate = 0.1

@export var explosionNode: PackedScene

var maxTimer = 5.0

var paused = false

var player

func _ready():
	maxTimer = timer


func _process(delta):
	if paused:
		timer -= delta
	
	var direction = player.position - position

	var desired_rotation = atan2(direction.y, direction.x)

	var rotation_diff = wrapf(desired_rotation - rotation, -PI, PI)

	rotation_diff = clamp(rotation_diff, -turn_rate, turn_rate)
	
	#Disable steering
	if timer >= 0 and not paused:
		rotation += rotation_diff #/ 4
	
	var velocity = Vector2.RIGHT.rotated(rotation)
	
	if not paused:
		position += velocity * delta * speed



func _on_visible_on_screen_notifier_2d_screen_exited():
	explode()


func _on_area_entered(area):
	var scoreCounter = get_parent().get_node("Score")
	scoreCounter.missile_boom()
	explode()
	
func explode():
	var boom = explosionNode.instantiate()
	boom.position = position
	get_parent().add_child(boom)
	queue_free()
