extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var LEFT = "LEFT"
var RIGHT = "RIGHT"
var result = "null"
var trigger = false

onready var coin = get_node("Coin")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("left"):
		result = LEFT
		coin.play("spinning")
	elif Input.is_action_just_released("right"):
		result = RIGHT

func _on_AnimatedSprite_animation_finished():
	if result == LEFT:
		#coin.stop();
		#coin.frame = 0
		result = "null"
	elif result == RIGHT:
		var flip = randi()%3+1
		if flip == 1:
			coin.play("one")
		elif flip == 2:
			coin.play("two")
		