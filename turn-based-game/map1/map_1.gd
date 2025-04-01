extends Node2D

@onready var camera = $camera as Camera2D

@onready var player1 = $player1 as CharacterBody2D
@onready var player2 = $player2 as CharacterBody2D
@onready var player3 = $player3 as CharacterBody2D
@onready var player4 = $player4 as CharacterBody2D
@onready var player5 = $player5 as CharacterBody2D
@onready var player6 = $player6 as CharacterBody2D
@onready var player7 = $player7 as CharacterBody2D
@onready var player8 = $player8 as CharacterBody2D

@onready var p1 = $camera/ui/p1
@onready var p2 = $camera/ui/p2
@onready var p3 = $camera/ui/p3
@onready var p4 = $camera/ui/p4
@onready var p5 = $camera/ui/p5
@onready var p6 = $camera/ui/p6
@onready var p7 = $camera/ui/p7
@onready var p8 = $camera/ui/p8

@onready var basicenemies = $enemies/basicenemies
@onready var stealthenemies = $enemies/stealthenemies
@onready var mageenemies = $enemies/mageenemies

@onready var health = $camera/ui/health
@onready var options = $camera/ui/options
@onready var attack = $camera/ui/attackui
@onready var melee = $camera/ui/attackui/melee
@onready var ranged = $camera/ui/attackui/ranged
@onready var magic = $camera/ui/attackui/magic
@onready var endturn = $camera/ui/attackui/endturn
@onready var switchactions = $camera/ui/switchactions
@onready var actions = $camera/ui/actions

@onready var v16p3 = $camera/ui/V16p3
@onready var attackui = $camera/ui/attackui

# x coords, y coords of enemies
var enemyDes = []
var enemyListXb = []
var enemyListYb = []
var enemyListXs = []
var enemyListYs = []
var enemyListXm = []
var enemyListYm = []

# x coords, y coords, index, and current coords
var charactersX = []
var charactersY = []
var charactersI = 0
var currentCharX
var currentCharY

# Hides the UI when changing to a different character (may need updated?)
func hideUI():
	if charactersI == 0:
		player2.get_node("ui").visible = false
		player3.get_node("ui").visible = false
		player4.get_node("ui").visible = false
		player5.get_node("ui").visible = false
		player6.get_node("ui").visible = false
		player7.get_node("ui").visible = false
		player8.get_node("ui").visible = false
	if charactersI == 1:
		player1.get_node("ui").visible = false
		player3.get_node("ui").visible = false
		player4.get_node("ui").visible = false
		player5.get_node("ui").visible = false
		player6.get_node("ui").visible = false
		player7.get_node("ui").visible = false
		player8.get_node("ui").visible = false
	if charactersI == 2:
		player1.get_node("ui").visible = false
		player2.get_node("ui").visible = false
		player4.get_node("ui").visible = false
		player5.get_node("ui").visible = false
		player6.get_node("ui").visible = false
		player7.get_node("ui").visible = false
		player8.get_node("ui").visible = false
	if charactersI == 3:
		player1.get_node("ui").visible = false
		player2.get_node("ui").visible = false
		player3.get_node("ui").visible = false
		player5.get_node("ui").visible = false
		player6.get_node("ui").visible = false
		player7.get_node("ui").visible = false
		player8.get_node("ui").visible = false
	if charactersI == 4:
		player1.get_node("ui").visible = false
		player2.get_node("ui").visible = false
		player3.get_node("ui").visible = false
		player4.get_node("ui").visible = false
		player6.get_node("ui").visible = false
		player7.get_node("ui").visible = false
		player8.get_node("ui").visible = false
	if charactersI == 5:
		player1.get_node("ui").visible = false
		player2.get_node("ui").visible = false
		player3.get_node("ui").visible = false
		player4.get_node("ui").visible = false
		player5.get_node("ui").visible = false
		player7.get_node("ui").visible = false
		player8.get_node("ui").visible = false
	if charactersI == 6:
		player1.get_node("ui").visible = false
		player2.get_node("ui").visible = false
		player3.get_node("ui").visible = false
		player4.get_node("ui").visible = false
		player5.get_node("ui").visible = false
		player6.get_node("ui").visible = false
		player8.get_node("ui").visible = false
	if charactersI == 7:
		player1.get_node("ui").visible = false
		player2.get_node("ui").visible = false
		player3.get_node("ui").visible = false
		player4.get_node("ui").visible = false
		player5.get_node("ui").visible = false
		player6.get_node("ui").visible = false
		player7.get_node("ui").visible = false

# Setting the collision data
func colDetect():
	charactersX = [player1.position.x, player2.position.x, player3.position.x, player4.position.x, player5.position.x, player6.position.x, player7.position.x, player8.position.x]
	charactersY = [player1.position.y, player2.position.y, player3.position.y, player4.position.y, player5.position.y, player6.position.y, player7.position.y, player8.position.y]
	for player in range(len(charactersX)):
		GlobalVars.pX[player] = charactersX[player]
		GlobalVars.pY[player] = charactersY[player]
	#enemyDes = [enemy1.get_editor_description(), enemy2.get_editor_description()]
	for i in range(len(basicenemies.get_children())):
		enemyListXb[i] = basicenemies.get_child(i).position.x
		enemyListYb[i] = basicenemies.get_child(i).position.y
	for e in range(len(stealthenemies.get_children())):
		enemyListXs[e] = stealthenemies.get_child(e).position.x
		enemyListYs[e] = stealthenemies.get_child(e).position.y
	for o in range(len(mageenemies.get_children())):
		enemyListXm[o] = mageenemies.get_child(o).position.x
		enemyListYm[o] = mageenemies.get_child(o).position.y
	for i in range(len(enemyListXb)):
		Map1gVars.eXb[i] = enemyListXb[i]
		Map1gVars.eYb[i] = enemyListYb[i]
	for e in range(len(enemyListXs)):
		Map1gVars.eXs[e] = enemyListXs[e]
		Map1gVars.eYs[e] = enemyListYs[e]
	for o in range(len(enemyListXm)):
		Map1gVars.eXm[o] = enemyListXm[o]
		Map1gVars.eYm[o] = enemyListYm[o]

func dispHealth(chara):
	if GlobalVars.phealth[chara] > 0: health.text = str("Health: " + str(GlobalVars.phealth[chara]) + "/" + str(GlobalVars.phealthT[chara]))
	else: health.text = "Dead"

func dispEHealthb(chara):
	if Map1gVars.eHb[chara] > 0: health.text = str("Health: " + str(Map1gVars.eHb[chara]) + "/" + str(Map1gVars.eHTb[chara]))
	else: health.text = "Dead"

func dispEHealths(chara):
	if Map1gVars.eHs[chara] > 0: health.text = str("Health: " + str(Map1gVars.eHs[chara]) + "/" + str(Map1gVars.eHTs[chara]))
	else: health.text = "Dead"

func dispEHealthm(chara):
	if Map1gVars.eHm[chara] > 0: health.text = str("Health: " + str(Map1gVars.eHm[chara]) + "/" + str(Map1gVars.eHTm[chara]))
	else: health.text = "Dead"

func dispOptions(chara):
	if not GlobalVars.player1Mode and chara == 0:
		if GlobalVars.phealth[0] <= 0: options.text = "Player dead"
		else: options.text = "Turn over"
		switchactions.text = "Switch character (up/down)"
		v16p3.visible = true
		attackui.visible = false
	elif not GlobalVars.player2Mode and chara == 1:
		if GlobalVars.phealth[1] <= 0: options.text = "Player dead"
		else: options.text = "Turn over"
		switchactions.text = "Switch character (up/down)"
		v16p3.visible = true
		attackui.visible = false
	elif not GlobalVars.player3Mode and chara == 2:
		if GlobalVars.phealth[2] <= 0: options.text = "Player dead"
		else: options.text = "Turn over"
		switchactions.text = "Switch character (up/down)"
		v16p3.visible = true
		attackui.visible = false
	elif not GlobalVars.player4Mode and chara == 3:
		if GlobalVars.phealth[3] <= 0: options.text = "Player dead"
		else: options.text = "Turn over"
		switchactions.text = "Switch character (up/down)"
		v16p3.visible = true
		attackui.visible = false
	elif not GlobalVars.player5Mode and chara == 4:
		if GlobalVars.phealth[4] <= 0: options.text = "Player dead"
		else: options.text = "Turn over"
		switchactions.text = "Switch character (up/down)"
		v16p3.visible = true
		attackui.visible = false
	elif not GlobalVars.player6Mode and chara == 5:
		if GlobalVars.phealth[5] <= 0: options.text = "Player dead"
		else: options.text = "Turn over"
		switchactions.text = "Switch character (up/down)"
		v16p3.visible = true
		attackui.visible = false
	elif not GlobalVars.player7Mode and chara == 6:
		if GlobalVars.phealth[6] <= 0: options.text = "Player dead"
		else: options.text = "Turn over"
		switchactions.text = "Switch character (up/down)"
		v16p3.visible = true
		attackui.visible = false
	elif not GlobalVars.player8Mode and chara == 7:
		if GlobalVars.phealth[7] <= 0: options.text = "Player dead"
		else: options.text = "Turn over"
		switchactions.text = "Switch character (up/down)"
		v16p3.visible = true
		attackui.visible = false
	elif not GlobalVars.optionMode and GlobalVars.playerMode:
		options.text = "Options (space)"
		switchactions.text = "Switch character (up/down)"
		v16p3.visible = true
		attackui.visible = false
	elif GlobalVars.optionMode and GlobalVars.playerMode:
		options.text = "Back (space)"
		switchactions.text = ""
		v16p3.visible = true
		attackui.visible = true
	if (GlobalVars.meleeMode or GlobalVars.rangedMode or GlobalVars.magicMode) and GlobalVars.playerMode:
		switchactions.text = "Use action (enter)"
		v16p3.visible = true
		attackui.visible = false

func dispEOptions():
	options.text = "Enemy turn"
	switchactions.text = ""
	v16p3.visible = false
	attackui.visible = false

func eAttack(enemyType):
	var damage
	if enemyType == "basic":
		damage = randi() % 11
	elif enemyType == "stealth":
		damage = randi() % 21
	elif enemyType == "mage":
		damage = randi() % 16
	return damage

# Called when the node enters the scene tree for the first time.
# Sets the basis of who starts and camera data
func _ready():
	if GlobalVars.playerMode:
		# Sets the size of the enemy lists
		enemyListXb.resize(len(basicenemies.get_children()))
		enemyListYb.resize(len(basicenemies.get_children()))
		enemyListXs.resize(len(stealthenemies.get_children()))
		enemyListYs.resize(len(stealthenemies.get_children()))
		enemyListXm.resize(len(mageenemies.get_children()))
		enemyListYm.resize(len(mageenemies.get_children()))
		Map1gVars.eXb.resize(len(basicenemies.get_children()))
		Map1gVars.eYb.resize(len(basicenemies.get_children()))
		Map1gVars.eXs.resize(len(stealthenemies.get_children()))
		Map1gVars.eYs.resize(len(stealthenemies.get_children()))
		Map1gVars.eXm.resize(len(mageenemies.get_children()))
		Map1gVars.eYm.resize(len(mageenemies.get_children()))
		Map1gVars.eTb.resize(len(basicenemies.get_children()))
		Map1gVars.eTs.resize(len(stealthenemies.get_children()))
		Map1gVars.eTm.resize(len(mageenemies.get_children()))
		# Gets collision data
		colDetect()
		# Allows for the enemies to actually attack
		for enemies in range(len(Map1gVars.eTb)):
			Map1gVars.eTb[enemies] = true
		for enemies in range(len(Map1gVars.eTs)):
			Map1gVars.eTs[enemies] = true
		for enemies in range(len(Map1gVars.eTm)):
			Map1gVars.eTm[enemies] = true
		# Sets the camera to the first character
		currentCharX = charactersX[charactersI]
		currentCharY = charactersY[charactersI]
		camera.position.x = currentCharX
		camera.position.y = currentCharY
		# Sets player modes
		GlobalVars.player1Current = true
		GlobalVars.player2Current = false
		GlobalVars.player3Current = false
		GlobalVars.player4Current = false
		GlobalVars.player5Current = false
		GlobalVars.player6Current = false
		GlobalVars.player7Current = false
		GlobalVars.player8Current = false
		if GlobalVars.phealth[0] <= 0: GlobalVars.player1Mode = false
		else: GlobalVars.player1Mode = true
		if GlobalVars.phealth[1] <= 0: GlobalVars.player2Mode = false
		else: GlobalVars.player2Mode = true
		if GlobalVars.phealth[2] <= 0: GlobalVars.player3Mode = false
		else: GlobalVars.player3Mode = true
		if GlobalVars.phealth[3] <= 0: GlobalVars.player4Mode = false
		else: GlobalVars.player4Mode = true
		if GlobalVars.phealth[4] <= 0: GlobalVars.player5Mode = false
		else: GlobalVars.player5Mode = true
		if GlobalVars.phealth[5] <= 0: GlobalVars.player6Mode = false
		else: GlobalVars.player6Mode = true
		if GlobalVars.phealth[6] <= 0: GlobalVars.player7Mode = false
		else: GlobalVars.player7Mode = true
		if GlobalVars.phealth[7] <= 0: GlobalVars.player8Mode = false
		else: GlobalVars.player8Mode = true
		GlobalVars.player1first = true
		GlobalVars.player2first = true
		GlobalVars.player3first = true
		GlobalVars.player4first = true
		GlobalVars.player5first = true
		GlobalVars.player6first = true
		GlobalVars.player7first = true
		GlobalVars.player8first = true
		# UI on the left
		p1.modulate = Color(1, 1, 1, 1)
		p2.modulate = Color(1, 1, 1, 0.5)
		p3.modulate = Color(1, 1, 1, 0.5)
		p4.modulate = Color(1, 1, 1, 0.5)
		p5.modulate = Color(1, 1, 1, 0.5)
		p6.modulate = Color(1, 1, 1, 0.5)
		p7.modulate = Color(1, 1, 1, 0.5)
		p8.modulate = Color(1, 1, 1, 0.5)
	elif GlobalVars.enemyMode:
		while GlobalVars.enemyMode:
			dispEOptions()
			p1.modulate = Color(1, 1, 1, 0.5)
			p2.modulate = Color(1, 1, 1, 0.5)
			p3.modulate = Color(1, 1, 1, 0.5)
			p4.modulate = Color(1, 1, 1, 0.5)
			p5.modulate = Color(1, 1, 1, 0.5)
			p6.modulate = Color(1, 1, 1, 0.5)
			p7.modulate = Color(1, 1, 1, 0.5)
			p8.modulate = Color(1, 1, 1, 0.5)
			for enemies in range(len(Map1gVars.eTb)):
				if Map1gVars.eTb[enemies] == true and Map1gVars.eHb[enemies] > 0:
					if detectPlayer(enemies, "basic") == true:
						dispEHealthb(enemies)
						actions.text = "Enemy is attacking"
						camera.position.x = enemyListXb[enemies]
						camera.position.y = enemyListYb[enemies]
						await get_tree().create_timer(2).timeout
						var charPos = choosePlayer(enemies, "basic")
						camera.position.x = GlobalVars.pX[charPos]
						camera.position.y = GlobalVars.pY[charPos]
						dispHealth(charPos)
						actions.text = "Attacking player"
						await get_tree().create_timer(2).timeout
						var damcalc = eAttack("basic")
						GlobalVars.phealth[charPos] -= damcalc
						dispHealth(charPos)
						if damcalc == 0: actions.text = "Miss"
						else: actions.text = str("Did " + str(damcalc) + " damage")
						await get_tree().create_timer(2).timeout
						actions.text = ""
					Map1gVars.eTb[enemies] = false
			for enemies in range(len(Map1gVars.eTs)):
				if Map1gVars.eTs[enemies] == true and Map1gVars.eHs[enemies] > 0:
					if detectPlayer(enemies, "stealth") == true:
						dispEHealths(enemies)
						actions.text = "Enemy is attacking"
						camera.position.x = enemyListXs[enemies]
						camera.position.y = enemyListYs[enemies]
						await get_tree().create_timer(2).timeout
						var charPos = choosePlayer(enemies, "stealth")
						camera.position.x = GlobalVars.pX[charPos]
						camera.position.y = GlobalVars.pY[charPos]
						dispHealth(charPos)
						actions.text = "Attacking player"
						await get_tree().create_timer(2).timeout
						var damcalc = eAttack("stealth")
						GlobalVars.phealth[charPos] -= damcalc
						dispHealth(charPos)
						if damcalc == 0: actions.text = "Miss"
						else: actions.text = str("Did " + str(damcalc) + " damage")
						await get_tree().create_timer(2).timeout
						actions.text = ""
					Map1gVars.eTs[enemies] = false
			for enemies in range(len(Map1gVars.eTm)):
				if Map1gVars.eTm[enemies] == true and Map1gVars.eHm[enemies] > 0:
					if detectPlayer(enemies, "mage") == true:
						dispEHealthm(enemies)
						actions.text = "Enemy is attacking"
						camera.position.x = enemyListXm[enemies]
						camera.position.y = enemyListYm[enemies]
						await get_tree().create_timer(2).timeout
						var charPos = choosePlayer(enemies, "mage")
						camera.position.x = GlobalVars.pX[charPos]
						camera.position.y = GlobalVars.pY[charPos]
						dispHealth(charPos)
						actions.text = "Attacking player"
						await get_tree().create_timer(2).timeout
						var damcalc = eAttack("mage")
						GlobalVars.phealth[charPos] -= damcalc
						dispHealth(charPos)
						if damcalc == 0: actions.text = "Miss"
						else: actions.text = str("Did " + str(damcalc) + " damage")
						await get_tree().create_timer(2).timeout
						actions.text = ""
					Map1gVars.eTm[enemies] = false
			GlobalVars.playerMode = true
			GlobalVars.enemyMode = false
			charactersI = 0
			_ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# DO NOT USE WAITS IN HERE.  IT WILL BREAK
func _process(_delta):
	hideUI()
	colDetect()
	# Player mode
	if GlobalVars.playerMode == true:
		dispHealth(charactersI)
		dispOptions(charactersI)
		currentCharX = charactersX[charactersI]
		currentCharY = charactersY[charactersI]
		camera.position.x = currentCharX
		camera.position.y = currentCharY
		# Goes to the next charater
		if Input.is_action_just_pressed("playernext") and not GlobalVars.meleeMode and not GlobalVars.rangedMode and not GlobalVars.magicMode and not GlobalVars.optionMode:
			if charactersI == 0:
				GlobalVars.player1Current = false
				p1.modulate = Color(1, 1, 1, 0.5)
				charactersI += 1
				GlobalVars.player2Current = true
				p2.modulate = Color(1, 1, 1, 1)
			elif charactersI == 1:
				GlobalVars.player3Current = true
				p3.modulate = Color(1, 1, 1, 1)
				charactersI += 1
				GlobalVars.player2Current = false
				p2.modulate = Color(1, 1, 1, 0.5)
			elif charactersI == 2:
				GlobalVars.player4Current = true
				p4.modulate = Color(1, 1, 1, 1)
				charactersI += 1
				GlobalVars.player3Current = false
				p3.modulate = Color(1, 1, 1, 0.5)
			elif charactersI == 3:
				GlobalVars.player5Current = true
				p5.modulate = Color(1, 1, 1, 1)
				charactersI += 1
				GlobalVars.player4Current = false
				p4.modulate = Color(1, 1, 1, 0.5)
			elif charactersI == 4:
				GlobalVars.player6Current = true
				p6.modulate = Color(1, 1, 1, 1)
				charactersI += 1
				GlobalVars.player5Current = false
				p5.modulate = Color(1, 1, 1, 0.5)
			elif charactersI == 5:
				GlobalVars.player7Current = true
				p7.modulate = Color(1, 1, 1, 1)
				charactersI += 1
				GlobalVars.player6Current = false
				p6.modulate = Color(1, 1, 1, 0.5)
			elif charactersI == 6:
				GlobalVars.player8Current = true
				p8.modulate = Color(1, 1, 1, 1)
				charactersI += 1
				GlobalVars.player7Current = false
				p7.modulate = Color(1, 1, 1, 0.5)
			elif charactersI == 7:
				GlobalVars.player8Current = true
				p8.modulate = Color(1, 1, 1, 1)
				GlobalVars.player7Current = false
				p7.modulate = Color(1, 1, 1, 0.5)
		# Goes to the previous character
		elif Input.is_action_just_pressed("playerprevious") and not GlobalVars.meleeMode and not GlobalVars.rangedMode and not GlobalVars.magicMode and not GlobalVars.optionMode:
			if charactersI == 0:
				GlobalVars.player1Current = true
				p1.modulate = Color(1, 1, 1, 1)
				GlobalVars.player2Current = false
				p2.modulate = Color(1, 1, 1, 0.5)
			elif charactersI == 1:
				GlobalVars.player2Current = false
				p2.modulate = Color(1, 1, 1, 0.5)
				charactersI -= 1
				GlobalVars.player1Current = true
				p1.modulate = Color(1, 1, 1, 1)
			elif charactersI == 2:
				GlobalVars.player3Current = false
				p3.modulate = Color(1, 1, 1, 0.5)
				charactersI -= 1
				GlobalVars.player2Current = true
				p2.modulate = Color(1, 1, 1, 1)
			elif charactersI == 3:
				GlobalVars.player4Current = false
				p4.modulate = Color(1, 1, 1, 0.5)
				charactersI -= 1
				GlobalVars.player3Current = true
				p3.modulate = Color(1, 1, 1, 1)
			elif charactersI == 4:
				GlobalVars.player5Current = false
				p5.modulate = Color(1, 1, 1, 0.5)
				charactersI -= 1
				GlobalVars.player4Current = true
				p4.modulate = Color(1, 1, 1, 1)
			elif charactersI == 5:
				GlobalVars.player6Current = false
				p6.modulate = Color(1, 1, 1, 0.5)
				charactersI -= 1
				GlobalVars.player5Current = true
				p5.modulate = Color(1, 1, 1, 1)
			elif charactersI == 6:
				GlobalVars.player7Current = false
				p7.modulate = Color(1, 1, 1, 0.5)
				charactersI -= 1
				GlobalVars.player6Current = true
				p6.modulate = Color(1, 1, 1, 1)
			elif charactersI == 7:
				GlobalVars.player8Current = false
				p8.modulate = Color(1, 1, 1, 0.5)
				charactersI -= 1
				GlobalVars.player7Current = true
				p7.modulate = Color(1, 1, 1, 1)
		# If the player turn is done, switches to enemy mode
		if not GlobalVars.player1Mode and not GlobalVars.player2Mode and not GlobalVars.player3Mode and not GlobalVars.player4Mode and not GlobalVars.player5Mode and not GlobalVars.player6Mode and not GlobalVars.player7Mode and not GlobalVars.player8Mode:
			GlobalVars.playerMode = false
			GlobalVars.enemyMode = true
			hideUI()
			colDetect()
			_ready()

# NEW ENEMY FUNCTIONS
# Used to see if there is a player within the radius of the enemy
func detectPlayer(enemies, enemyType):
	# Used to determine if a player has been found or not
	var charChosenA = false
	if enemyType == "basic":
		var enPosX = Map1gVars.eXb[enemies]
		var enPosY = Map1gVars.eYb[enemies]
		for chars in range(len(GlobalVars.pX)):
			if abs(enPosX - GlobalVars.pX[chars]) <= 16*5 and abs(enPosY - GlobalVars.pY[chars]) <= 16*5 and GlobalVars.phealth[chars] > 0:
				charChosenA = true
			else: continue
		if not charChosenA:
			pass
	elif enemyType == "stealth":
		var enPosX = Map1gVars.eXs[enemies]
		var enPosY = Map1gVars.eYs[enemies]
		for chars in range(len(GlobalVars.pX)):
			if abs(enPosX - GlobalVars.pX[chars]) <= 16*10 and abs(enPosY - GlobalVars.pY[chars]) <= 16*10 and GlobalVars.phealth[chars] > 0:
				charChosenA = true
			else: continue
		if not charChosenA:
			pass
	elif enemyType == "mage":
		var enPosX = Map1gVars.eXm[enemies]
		var enPosY = Map1gVars.eYm[enemies]
		for chars in range(len(GlobalVars.pX)):
			if abs(enPosX - GlobalVars.pX[chars]) <= 16*10 and abs(enPosY - GlobalVars.pY[chars]) <= 16*10 and GlobalVars.phealth[chars] > 0:
				charChosenA = true
			else: continue
		if not charChosenA:
			pass
	return charChosenA

func choosePlayer(enemies, enemyType):
	var playerC = 9
	if enemyType == "basic":
		var enPosX = Map1gVars.eXb[enemies]
		var enPosY = Map1gVars.eYb[enemies]
		var charPX = 10000000
		var charPY = 10000000
		for chars in range(len(GlobalVars.pX)):
			if abs(enPosX - GlobalVars.pX[chars]) <= 16*5 and abs(enPosY - GlobalVars.pY[chars]) <= 16*5 and GlobalVars.phealth[chars] > 0:
				if abs(enPosX - GlobalVars.pX[chars]) <= charPX and abs(enPosY - GlobalVars.pY[chars]) <= charPY:
					playerC = chars
					charPX = abs(enPosX - GlobalVars.pX[chars])
					charPY = abs(enPosY - GlobalVars.pY[chars])
			else: continue
	elif enemyType == "stealth":
		var enPosX = Map1gVars.eXs[enemies]
		var enPosY = Map1gVars.eYs[enemies]
		var charPX = 0
		var charPY = 0
		for chars in range(len(GlobalVars.pX)):
			if abs(enPosX - GlobalVars.pX[chars]) <= 16*10 and abs(enPosY - GlobalVars.pY[chars]) <= 16*10 and GlobalVars.phealth[chars] > 0:
				if abs(enPosX - GlobalVars.pX[chars]) >= charPX and abs(enPosY - GlobalVars.pY[chars]) >= charPY:
					playerC = chars
					charPX = abs(enPosX - GlobalVars.pX[chars])
					charPY = abs(enPosY - GlobalVars.pY[chars])
			else: continue
	elif enemyType == "mage":
		var enPosX = Map1gVars.eXm[enemies]
		var enPosY = Map1gVars.eYm[enemies]
		var charPX = 0
		var charPY = 0
		var testH = 10000
		for chars in range(len(GlobalVars.pX)):
			if abs(enPosX - GlobalVars.pX[chars]) <= 16*10 and abs(enPosY - GlobalVars.pY[chars]) <= 16*10 and GlobalVars.phealth[chars] > 0:
				if abs(enPosX - GlobalVars.pX[chars]) >= charPX and abs(enPosY - GlobalVars.pY[chars]) >= charPY:
					if testH >= GlobalVars.phealth[chars]:
						playerC = chars
						charPX = abs(enPosX - GlobalVars.pX[chars])
						charPY = abs(enPosY - GlobalVars.pY[chars])
			else: continue
	return playerC
