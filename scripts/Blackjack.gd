extends Node2D

var result = "null"
var trigger = false
var comptrigger = false

var flip = 0
var compflip = 0

var p_result = 0
var c_result = 0

var playertotal = 0
var comptotal = 0

var pdone = false
var cdone = false

var bet = 1

var MAX_ONE = 25
var MAX_TWO = 25
var ones = 25
var twos = 25

var LEFT = true
var UP = true

var roundstarted = false
var running = false

var playercoinsnum = 0

onready var global = get_node("/root/Global")

onready var playercoins = get_node("PlayerCoins/CoinTotal")

onready var onestotal = get_node("OnesTotal")
onready var twostotal = get_node("TwosTotal")

onready var coin = get_node("CoinPlayer")
onready var comp = get_node("CoinComp")

onready var pTimer = get_node("PlayerTimer")
onready var cTimer = get_node("CompTimer")

onready var pTotalLabel = get_node("PTotalLabel")
onready var cTotalLabel = get_node("CTotalLabel")

onready var music = get_node("AudioStreamPlayer")
onready var coinsound = get_node("AudioStreamPlayer2")
onready var hurtsound = get_node("AudioStreamPlayer3")

# Buttons
onready var exit = get_node("Exit")
onready var hit = get_node("Hit") 
onready var stay = get_node("Stay") 
onready var double = get_node("Double") 

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	global.start_fountain = true
	coin.stop()
	coin.frame = 0
	comp.stop()
	comp.frame = 0
	music.play(0)
	hardreset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pdone and cdone and playertotal < 8 and comptotal < 8:
		comparetotals()
	
	if ones == 0 and twos == 0:
		ones = MAX_ONE
		twos = MAX_TWO
	
	if not global.coins == playercoinsnum:
		playercoinsnum = global.coins
		playercoins.set_text(str(playercoinsnum))
	
	onestotal.set_text(str(ones))
	twostotal.set_text(str(twos))
	
	pTotalLabel.set_text(str(playertotal))
	cTotalLabel.set_text(str(comptotal))
	
	if Input.is_action_just_pressed("reset"):
		hardreset()

	if Input.is_action_just_pressed("left") and not running:
		LEFT = true
	if Input.is_action_just_pressed("right") and not running:
		LEFT = false
	if Input.is_action_just_pressed("up") and not running:
		UP = true
	if Input.is_action_just_pressed("down") and not running:
		UP = false
		
	if LEFT and UP: # HIT
		hit.play("selected")
		stay.play("empty")
		double.play("empty")
		exit.play("empty")
		if Input.is_action_just_pressed("confirm") and not running:
			if not roundstarted and global.coins > 0:
				roundstarted = true
				global.coins -= 1
				running = true
				hitplayer()
			elif roundstarted:
				running = true
				hitplayer()
	elif LEFT and not UP: # DOUBLE
		hit.play("empty")
		stay.play("empty")
		double.play("selected")
		exit.play("empty")
		if Input.is_action_just_pressed("confirm") and roundstarted and not running and global.coins > 0:
			bet = 2
			pdone = true
			hitplayer()
	elif not LEFT and UP: # STAY
		hit.play("empty")
		stay.play("selected")
		double.play("empty")
		exit.play("empty")
		if Input.is_action_just_pressed("confirm") and roundstarted and not running:
			pdone = true
			if not cdone and comptotal < 7:
				hitcomp()
	elif not LEFT and not UP: # EXIT
		hit.play("empty")
		stay.play("empty")
		double.play("empty")
		if roundstarted:
			exit.play("disabled")
		else:
			exit.play("selected")
			if Input.is_action_just_pressed("confirm"):
				get_tree().change_scene("res://scenes/Level1.tscn")
		
func _on_AnimatedSprite_animation_finished():
	coin.stop()
	
func _on_CoinComp_animation_finished():
	comp.stop()

func resetplayer():
	if trigger:
		#coin.play("spinning")
		if p_result == 1:
			coin.play("reset1")
		elif p_result == 2:
			coin.play("reset2")
		flip = 0
		trigger = false
		if comptotal < 7:
			hitcomp()
		else:
			cdone = true
		if cdone:
			running = false
		
func resetcomp():
	if comptrigger:
		#coin.play("spinning")
		if c_result == 1:
			comp.play("reset1")
		elif c_result == 2:
			comp.play("reset2")
		compflip = 0
		comptrigger = false
		running = false
		
func resetboth():
	if p_result == 1:
		coin.play("reset1")
	elif p_result == 2:
		coin.play("reset2")
	flip = 0
	trigger = false
	if c_result == 1:
		comp.play("reset1")
	elif c_result == 2:
		comp.play("reset2")
	compflip = 0
	comptrigger = false
	running = false
		
func hitplayer():
	var maxdeck = ones + twos
	if not coin.is_playing() and not trigger:
			flip = randi()%maxdeck+1
			print(flip)
			if flip <= ones: # player rolls a one
				ones -= 1
				playertotal += 1
				p_result = 1
				coin.frame = 0
				coin.play("one")
			else:
				twos -= 1
				playertotal += 2
				p_result = 2
				coin.frame = 0
				coin.play("two")
			trigger = true
			checkwinner(true)
			
func hitcomp():
	var maxdeck = ones + twos
	if not comp.is_playing() and not comptrigger:
			compflip = randi()%maxdeck+1
			print(compflip)
			if compflip <= ones: # player rolls a one
				ones -= 1
				comptotal += 1
				c_result = 1
				comp.frame = 0
				comp.play("one")
			else:
				twos -= 1
				comptotal += 2
				c_result = 2
				comp.frame = 0
				comp.play("two")
			comptrigger = true
			checkwinner(false)
			
func checkwinner(isPlayer):
	if isPlayer:
		if playertotal < 8: # Comp Goes
			pTimer.start(2)
		elif playertotal == 8: # autowin
			result(1)
		else: # bust
			result(0)
	else:
		if comptotal < 8: # continue
			cTimer.start(2)
		elif comptotal == 8: # autolose
			result(0)
		else: # comp busts, autowin
			result(2)
			
func comparetotals():
	if playertotal > comptotal:
		result(2)
	elif playertotal < comptotal:
		result(0)
	elif playertotal == comptotal:
		result(3)
			
func result(case):
	if case == 0: # plain reset
		hurtsound.play(0)
	elif case == 1: # Player Blackjack, if Player bet 1 gets 3, if bed 2 gets 5
		global.coins += (bet * 2) + 1
		coinsound.play(0)
	elif case == 2: # Comp Bust, Normal Payout2 times the amount paid
		global.coins += (bet * 2)
		coinsound.play(0)
	elif case == 3: # Same Number, Push
		global.coins += bet
		coinsound.play(0)
	resetboth()
	playertotal = 0
	comptotal = 0
	roundstarted = false
	running = false
	bet = 1
	c_result = 0
	p_result = 0
	pdone = false
	cdone = false

func _on_PlayerTimer_timeout():
	pTimer.stop()
	resetplayer()

func _on_CompTimer_timeout():
	cTimer.stop()
	resetcomp()

func _on_AudioStreamPlayer2_finished():
	coinsound.stop()

func _on_AudioStreamPlayer3_finished():
	hurtsound.stop()

func hardreset():
	result = "null"
	trigger = false
	comptrigger = false
	flip = 0
	compflip = 0
	p_result = 0
	c_result = 0
	playertotal = 0
	comptotal = 0
	pdone = false
	cdone = false
	bet = 1
	MAX_ONE = 25
	MAX_TWO = 25
	ones = 25
	twos = 25
	LEFT = true
	UP = true
	roundstarted = false
	running = false
	playercoinsnum = 0