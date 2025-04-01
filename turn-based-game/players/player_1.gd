extends CharacterBody2D


var currentX
var currentY
var movXpos
var movYpos
var movXneg
var movYneg
var rmovXpos
var rmovXneg
var rmovYpos
var rmovYneg
var ogposX
var ogposY
var vis

@onready var ui = $"ui"

func checkPos(playerX, playerY, prevX, prevY):
	# Map boundaries
	position.x = Map1gVars.map1ColX(playerX, playerY, prevX, prevY)
	position.y = Map1gVars.map1ColY(playerX, playerY, prevX, prevY)
	# Movement boundaries
	moveCheck()
	for player in range(len(GlobalVars.pX)):
		if player == 0:
			pass
		elif position.x == GlobalVars.pX[player] and position.y == GlobalVars.pY[player]:
			position.x = prevX
			position.y = prevY
	# Enemy collision
	for enemies in range(len(Map1gVars.eXb)):
		if position.x == Map1gVars.eXb[enemies] and position.y == Map1gVars.eYb[enemies] and Map1gVars.eHb[enemies] > 0:
			position.x = prevX
			position.y = prevY
	for enemies in range(len(Map1gVars.eXs)):
		if position.x == Map1gVars.eXs[enemies] and position.y == Map1gVars.eYs[enemies] and Map1gVars.eHs[enemies] > 0:
			position.x = prevX
			position.y = prevY

func damageCheck():
	for enemies in range(len(Map1gVars.eXb)):
		if position.x == Map1gVars.eXb[enemies] and position.y == Map1gVars.eYb[enemies]:
			Map1gVars.eHb[enemies] -= randi() % 11
	for enemies in range(len(Map1gVars.eXs)):
		if position.x == Map1gVars.eXs[enemies] and position.y == Map1gVars.eYs[enemies]:
			Map1gVars.eHs[enemies] -= randi() % 11
	for enemies in range(len(Map1gVars.eXm)):
		if position.x == Map1gVars.eXm[enemies] and position.y == Map1gVars.eYm[enemies]:
			Map1gVars.eHm[enemies] -= randi() % 11

func moveCheck():
	if position.x >= movXpos or position.y >= movYpos or position.x <= movXneg or position.y <= movYneg:
		position.x = currentX
		position.y = currentY

func _input(_event):
	# Needed in the if statements since you can't just do not ui.visible
	vis = ui.visible
	if GlobalVars.player1first:
		movXpos = 16*5 + position.x
		movYpos = 16*5 + position.y
		movXneg = position.x - 16*5
		movYneg = position.y - 16*5
		GlobalVars.player1first = false
	currentX = position.x
	currentY = position.y
	if Input.is_action_just_pressed("left") and not vis and GlobalVars.player1Mode and GlobalVars.player1Current:
		position.x -= 16
		if GlobalVars.p1melee or GlobalVars.p1ranged or GlobalVars.p1magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("right") and not vis and GlobalVars.player1Mode and GlobalVars.player1Current:
		position.x += 16
		if GlobalVars.p1melee or GlobalVars.p1ranged or GlobalVars.p1magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("up") and not vis and GlobalVars.player1Mode and GlobalVars.player1Current:
		position.y -= 16
		if GlobalVars.p1melee or GlobalVars.p1ranged or GlobalVars.p1magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("down") and not vis and GlobalVars.player1Mode and GlobalVars.player1Current:
		position.y += 16
		if GlobalVars.p1melee or GlobalVars.p1ranged or GlobalVars.p1magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("enter") and not vis and GlobalVars.player1Mode and GlobalVars.player1Current and (GlobalVars.p1melee or GlobalVars.p1ranged or GlobalVars.p1magic):
		damageCheck()
		position.x = ogposX
		position.y = ogposY
		GlobalVars.meleeMode = false
		GlobalVars.rangedMode = false
		GlobalVars.magicMode = false
		GlobalVars.p1melee = false
		GlobalVars.p1ranged = false
		GlobalVars.p1magic = false
		GlobalVars.player1Current = false
		GlobalVars.player1Mode = false
		GlobalVars.optionMode = false
	elif Input.is_action_just_pressed("menu") and not vis and GlobalVars.player1Mode and GlobalVars.player1Current:
		z_index = 1
		GlobalVars.optionMode = true
		if GlobalVars.p1melee or GlobalVars.p1ranged or GlobalVars.p1magic:
			position.x = ogposX
			position.y = ogposY
			GlobalVars.p1melee = false
			GlobalVars.p1ranged = false
			GlobalVars.p1magic = false
			GlobalVars.meleeMode = false
			GlobalVars.rangedMode = false
			GlobalVars.magicMode = false
			movXneg = rmovXneg
			movXpos = rmovXpos
			movYpos = rmovYpos
			movYneg = rmovYneg
		ui.visible = true
	elif Input.is_action_just_pressed("melee") and vis and GlobalVars.player1Mode and GlobalVars.player1Current:
		GlobalVars.p1melee = true
		GlobalVars.meleeMode = true
		rmovXneg = movXneg
		rmovXpos = movXpos
		rmovYpos = movYpos
		rmovYneg = movYneg
		ogposX = position.x
		ogposY = position.y
		movXpos = 16*2 + position.x
		movYpos = 16*2 + position.y
		movXneg = position.x - 16*2
		movYneg = position.y - 16*2
		ui.visible = false
	elif Input.is_action_just_pressed("ranged") and vis and GlobalVars.player1Mode and GlobalVars.player1Current:
		GlobalVars.p1ranged = true
		GlobalVars.rangedMode = true
		rmovXneg = movXneg
		rmovXpos = movXpos
		rmovYpos = movYpos
		rmovYneg = movYneg
		ogposX = position.x
		ogposY = position.y
		movXpos = 16*5 + position.x
		movYpos = 16*5 + position.y
		movXneg = position.x - 16*5
		movYneg = position.y - 16*5
		ui.visible = false
	elif Input.is_action_just_pressed("magic") and vis and GlobalVars.player1Mode and GlobalVars.player1Current:
		#need to get this finished
		pass
	elif Input.is_action_just_pressed("endturn") and vis and GlobalVars.player1Mode and GlobalVars.player1Current:
		ui.visible = false
		GlobalVars.meleeMode = false
		GlobalVars.rangedMode = false
		GlobalVars.magicMode = false
		GlobalVars.p1melee = false
		GlobalVars.p1ranged = false
		GlobalVars.p1magic = false
		GlobalVars.player1Mode = false
		GlobalVars.player1Current = false
		GlobalVars.optionMode = false
	elif Input.is_action_just_pressed("menu") and vis and GlobalVars.player1Mode and GlobalVars.player1Current:
		z_index = 0
		ui.visible = false
		GlobalVars.meleeMode = false
		GlobalVars.rangedMode = false
		GlobalVars.magicMode = false
		GlobalVars.p1melee = false
		GlobalVars.p1ranged = false
		GlobalVars.p1magic = false
		GlobalVars.optionMode = false
