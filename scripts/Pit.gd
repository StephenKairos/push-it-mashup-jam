extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player = null

var playerentered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not player == null and playerentered:
		player.fall()

func _on_Area2D_body_entered(body):
	if body.name == "PirateSlime":
		player = body
		playerentered = true

func _on_Area2D_body_exited(body):
	if body.name == "PirateSlime":
		player = null
		playerentered = false