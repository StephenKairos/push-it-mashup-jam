extends Node2D

onready var sound = get_node("AudioStreamPlayer")

func _ready():
	sound.play(0)

func _process(delta):
	if Input.is_action_just_released("confirm"):
		get_tree().change_scene("res://scenes/Level1.tscn")