extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global")
onready var coinCount = get_node("CoinCount")

onready var heart1 = get_node("Heart")
onready var heart2 = get_node("Heart2")
onready var heart3 = get_node("Heart3")
onready var heart4 = get_node("Heart4")

onready var mush = get_node("mushroom")
onready var key = get_node("redkey")

var coins = 0
var hearts = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	key.visible = false
	mush.visible = false
	heart4.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not global.coins == coins:
		coins = global.coins
		coinCount.set_text(str(coins))
	if not global.lives == hearts:
		hearts = global.lives
		print(hearts)
		if hearts == 4:
			heart1.play("full")
			heart2.play("full")
			heart3.play("full")
			heart4.visible = true
		else:
			heart4.visible = false
			if hearts == 3:
				heart1.play("full")
				heart2.play("full")
				heart3.play("full")
			elif hearts == 2:
				heart1.play("full")
				heart2.play("full")
				heart3.play("empty")
			elif hearts == 1:
				heart1.play("full")
				heart2.play("empty")
				heart3.play("empty")
			elif hearts == 0:
				heart1.play("empty")
				heart2.play("empty")
				heart3.play("empty")
	if global.mushrooms > 0:
		mush.visible = true
	if global.redkey:
		key.visible = true