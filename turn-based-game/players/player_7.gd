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
		if player == 6:
			pass
		elif position.x == GlobalVars.pX[player] and position.y == GlobalVars.pY[player]:
			position.x = currentX
			position.y = currentY
	# Enemy collision
	for enemies in range(len(Map1gVars.eXb)):
		if position.x == Map1gVars.eXb[enemies] and position.y == Map1gVars.eYb[enemies]:
			position.x = currentX
			position.y = currentY
	for enemies in range(len(Map1gVars.eXs)):
		if position.x == Map1gVars.eXs[enemies] and position.y == Map1gVars.eYs[enemies]:
			position.x = currentX
			position.y = currentY

func damageCheck():
	for enemies in range(len(Map1gVars.eX)):
		if position.x == Map1gVars.eX[enemies] and position.y == Map1gVars.eY[enemies]:
			Map1gVars.eH[enemies] -= 5

func moveCheck():
	if position.x >= movXpos or position.y >= movYpos or position.x <= movXneg or position.y <= movYneg:
		position.x = currentX
		position.y = currentY

func _input(_event):
	vis = ui.visible
	if GlobalVars.player7first:
		movXpos = 16*5 + position.x
		movYpos = 16*5 + position.y
		movXneg = position.x - 16*5
		movYneg = position.y - 16*5
		GlobalVars.player7first = false
	currentX = position.x
	currentY = position.y
	if Input.is_action_just_pressed("left") and not vis and GlobalVars.player7Mode and GlobalVars.player7Current:
		position.x -= 16
		if GlobalVars.p7melee or GlobalVars.p7ranged or GlobalVars.p7magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("right") and not vis and GlobalVars.player7Mode and GlobalVars.player7Current:
		position.x += 16
		if GlobalVars.p7melee or GlobalVars.p7ranged or GlobalVars.p7magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("up") and not vis and GlobalVars.player7Mode and GlobalVars.player7Current:
		position.y -= 16
		if GlobalVars.p7melee or GlobalVars.p7ranged or GlobalVars.p7magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("down") and not vis and GlobalVars.player7Mode and GlobalVars.player7Current:
		position.y += 16
		if GlobalVars.p7melee or GlobalVars.p7ranged or GlobalVars.p7magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("enter") and not vis and GlobalVars.player7Mode and GlobalVars.player7Current and (GlobalVars.p7melee or GlobalVars.p7ranged or GlobalVars.p7magic):
		damageCheck()
		position.x = ogposX
		position.y = ogposY
		GlobalVars.meleeMode = false
		GlobalVars.rangedMode = false
		GlobalVars.magicMode = false
		GlobalVars.p7melee = false
		GlobalVars.p7ranged = false
		GlobalVars.p7magic = false
		GlobalVars.player7Current = false
		GlobalVars.player7Mode = false
		GlobalVars.optionMode = false
	elif Input.is_action_just_pressed("menu") and not vis and GlobalVars.player7Mode and GlobalVars.player7Current:
		z_index = 1
		GlobalVars.optionMode = true
		if GlobalVars.p7melee or GlobalVars.p7ranged or GlobalVars.p7magic:
			position.x = ogposX
			position.y = ogposY
			GlobalVars.p7melee = false
			GlobalVars.p7ranged = false
			GlobalVars.p7magic = false
			GlobalVars.meleeMode = false
			GlobalVars.rangedMode = false
			GlobalVars.magicMode = false
			movXneg = rmovXneg
			movXpos = rmovXpos
			movYpos = rmovYpos
			movYneg = rmovYneg
		ui.visible = true
	elif Input.is_action_just_pressed("melee") and vis and GlobalVars.player7Mode and GlobalVars.player7Current:
		GlobalVars.p7melee = true
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
	elif Input.is_action_just_pressed("ranged") and vis and GlobalVars.player7Mode and GlobalVars.player7Current:
		GlobalVars.p7ranged = true
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
	elif Input.is_action_just_pressed("magic") and vis and GlobalVars.player7Mode and GlobalVars.player7Current:
		#need to get this finished
		pass
	elif Input.is_action_just_pressed("endturn") and vis and GlobalVars.player7Mode and GlobalVars.player7Current:
		ui.visible = false
		GlobalVars.meleeMode = false
		GlobalVars.rangedMode = false
		GlobalVars.magicMode = false
		GlobalVars.p7melee = false
		GlobalVars.p7ranged = false
		GlobalVars.p7magic = false
		GlobalVars.player7Mode = false
		GlobalVars.player7Current = false
		GlobalVars.optionMode = false
	elif Input.is_action_just_pressed("menu") and vis and GlobalVars.player7Mode and GlobalVars.player7Current:
		z_index = 0
		ui.visible = false
		GlobalVars.meleeMode = false
		GlobalVars.rangedMode = false
		GlobalVars.magicMode = false
		GlobalVars.p7melee = false
		GlobalVars.p7ranged = false
		GlobalVars.p7magic = false
		GlobalVars.optionMode = false
