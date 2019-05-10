extends Node2D

onready var timer = get_node("Timer")
onready var sound = get_node("AudioStreamPlayer")

var ready = false

func _ready():
	timer.start(1)
	sound.play(0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("confirm") and ready:
		get_tree().change_scene("res://scenes/Title.tscn")

func _on_Timer_timeout():
	timer.stop()
	ready = true