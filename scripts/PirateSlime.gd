extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 200 # Pixels/second

var speed = 200

onready var global = get_node("/root/Global")
onready var slime = get_node("Slime")


func _ready():
	slime.play("idle")

func _physics_process(delta):
	var motion = Vector2()
	var force = Vector2()
	
	if Input.is_action_pressed("left"):
		force += Vector2(-1, 0)
	if Input.is_action_pressed("right"):
		force += Vector2(1, 0)
	if Input.is_action_pressed("up"):
		force += Vector2(0, -1)
	if Input.is_action_pressed("down"):
		force += Vector2(0, 1)
		
	if Input.is_action_pressed("left"):
		slime.play("left")
	elif Input.is_action_pressed("right"):
		slime.play("right")		
	elif Input.is_action_pressed("up"):
		slime.play("up")
	elif Input.is_action_pressed("down"):
		slime.play("down")
	
	if not Input.is_action_pressed("left") and not Input.is_action_pressed("right") and not Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		slime.play("idle")
	
	motion += force
	motion = motion.normalized() * speed

	var collision = move_and_slide(motion)
