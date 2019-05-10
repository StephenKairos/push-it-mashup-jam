extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global")

onready var player = get_node("PirateSlime")
onready var dungeonmusic = get_node("dungeonmusic1")
onready var fountainmusic = get_node("fountainmusic")
onready var storemusic = get_node("storemusic")

var fountain = false
var dungeon = true
var store = false

# Called when the node enters the scene tree for the first time.
func _ready():
	dungeonmusic.volume_db = -10
	dungeonmusic.play(0) # Replace with function body.

func _enter_tree():
	global = get_node("/root/Global")
	player = get_node("PirateSlime")
	
	print(global.start_fountain)
	
	if not global.start_fountain:
		player.position = global.beginning
	else:
		player.position = global.fountain

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not fountain and not store:
		dungeon = true
	else:
		dungeon = false
		
	if fountain:
		if dungeonmusic.playing:
			if dungeonmusic.volume_db > -40:
				dungeonmusic.volume_db -= 1
			else: 
				dungeonmusic.stop()
		if storemusic.playing:
			if storemusic.volume_db > -40:
				storemusic.volume_db -= 1
			else: 
				storemusic.stop()
		if fountainmusic.playing:
			if fountainmusic.volume_db < 0:
				fountainmusic.volume_db += 1
		else:
			fountainmusic.volume_db = -30
			fountainmusic.play(0)
	elif store:
		if dungeonmusic.playing:
			if dungeonmusic.volume_db > -40:
				dungeonmusic.volume_db -= 1
			else: 
				dungeonmusic.stop()
		if fountainmusic.playing:
			if fountainmusic.volume_db > -30:
				fountainmusic.volume_db -= 1
			else: 
				fountainmusic.stop()
		if storemusic.playing:
			if storemusic.volume_db < -10:
				storemusic.volume_db += 1
		else:
			storemusic.volume_db = -40
			storemusic.play(0)
	elif dungeon:
		if fountainmusic.playing:
			if fountainmusic.volume_db > -30:
				fountainmusic.volume_db -= 1
			else: 
				fountainmusic.stop()
		if storemusic.playing:
			if storemusic.volume_db > -40:
				storemusic.volume_db -= 1
			else: 
				storemusic.stop()
		if dungeonmusic.playing:
			if dungeonmusic.volume_db < -10:
				dungeonmusic.volume_db += 1
		else:
			dungeonmusic.volume_db = -40
			dungeonmusic.play(0)

func crossfadefountain(body):
	if body.name == "PirateSlime":
		fountain = true

func fadefountain(body):
	if body.name == "PirateSlime":
		fountain = false

func crossfadestore(body):
	if body.name == "PirateSlime":
		store = true

func fadestore(body):
	if body.name == "PirateSlime":
		store = false