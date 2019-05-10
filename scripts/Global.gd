extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var coins = 0
var mushrooms = 0
var redkey = false
var bluekey = false
var skullkey = false

var deckone = 25
var decktwo = 25

var MAX_LIVES = 3
var lives = 3

var start_fountain = false
var beginning = Vector2(2112, 4032)
var fountain = Vector2(2112, 2688)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lives <= 0:
		reset()
		get_tree().change_scene("res://scenes/GameOver.tscn")
		
func reset():
	coins = 0
	mushrooms = 0
	redkey = false
	lives = 3
	start_fountain = false