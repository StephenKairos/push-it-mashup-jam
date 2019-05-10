extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 200 # Pixels/second

var speed = 300

onready var global = get_node("/root/Global")
onready var slime = get_node("Slime")
onready var hurtsound = get_node("Hurt")

var platform = Vector2(0, 0)
var platformspeed = 0
var platform_immune = 0
var reset = Vector2(2112, 4120)
var ishurt = false
var hurttimer = 0

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
		if ishurt:
			slime.play("hurt")
		else:
			slime.play("idle")
	
	if ishurt:
		hurttimer -= 1
		if hurttimer == 0:
			ishurt = false
	
	motion += (force.normalized() * speed) + (platform * platformspeed)

	var collision = move_and_slide(motion)

func transportplatform(force, pspeed, immune):
	platform += force
	platformspeed = pspeed
	platform_immune += immune

func fall():
	if platform_immune <= 0:
		position = reset
		hurtsound.play(0)
		if not ishurt:
			global.lives -= 1
		ishurt = true
		hurttimer = 50
	
func set_spawn(pos):
	reset = pos