extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var wish = get_node("Wish")

# Called when the node enters the scene tree for the first time.
func _ready():
	wish.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wish.visible and Input.is_action_just_pressed("confirm"):
		get_tree().change_scene("res://scenes/Blackjack.tscn")

func _on_WellArea_body_entered(body):
	if body.name == "PirateSlime":
		wish.visible = true

func _on_WellArea_body_exited(body):
	if body.name == "PirateSlime":
		wish.visible = false