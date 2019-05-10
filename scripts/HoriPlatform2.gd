extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 150
var direction = 1
var player = null

var playerentered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move = speed * direction
	position.x += delta * move

func _on_VertPlatform2_body_entered(body):
	if body.name == "TileMap":
		direction *= -1
		if playerentered:
			player.transportplatform(Vector2(direction * 2, 0), speed, 0)
	if body.name == "PirateSlime":
		body.transportplatform(Vector2(direction, 0), speed, 1)
		player = body
		playerentered = true

func _on_VertPlatform2_body_exited(body):
	if body.name == "PirateSlime":
		player = null
		playerentered = false
		body.transportplatform(Vector2(direction * (-1), 0), speed, -1)
