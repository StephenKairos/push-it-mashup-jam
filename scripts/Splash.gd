extends Node2D

onready var mashuplogo = get_node("AnimatedSprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	mashuplogo.play("float") 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("up"):
		get_tree().change_scene("res://scenes/Example.tscn")

func _on_AnimatedSprite_animation_finished():
	pass #mashuplogo.play("float")
