extends Node2D

onready var mashuplogo = get_node("AnimatedSprite")
onready var timer = get_node("Timer")
onready var timer2 = get_node("Timer2")
onready var sound = get_node("AudioStreamPlayer")

var ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	mashuplogo.frame = 0
	timer.start(1.5)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_AnimatedSprite_animation_finished():
	if ready:
		mashuplogo.play("float")
		sound.play(0)
		ready = false
		timer2.start(4)
		

func _on_Timer_timeout():
	timer.stop()
	mashuplogo.play("intro")
	ready = true


func _on_Timer2_timeout():
	timer2.stop()
	get_tree().change_scene("res://scenes/Title.tscn")
