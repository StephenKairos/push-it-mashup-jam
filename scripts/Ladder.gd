extends Area2D

var player = "PirateSlime"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_HeartShop_body_entered(body):
	if body.name == player:
		get_tree().change_scene("res://scenes/Congrats.tscn")