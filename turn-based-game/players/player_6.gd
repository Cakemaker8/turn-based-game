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
		if player == 5:
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
	if GlobalVars.player6first:
		movXpos = 16*5 + position.x
		movYpos = 16*5 + position.y
		movXneg = position.x - 16*5
		movYneg = position.y - 16*5
		GlobalVars.player6first = false
	currentX = position.x
	currentY = position.y
	if Input.is_action_just_pressed("left") and not vis and GlobalVars.player6Mode and GlobalVars.player6Current:
		position.x -= 16
		if GlobalVars.p6melee or GlobalVars.p6ranged or GlobalVars.p6magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("right") and not vis and GlobalVars.player6Mode and GlobalVars.player6Current:
		position.x += 16
		if GlobalVars.p6melee or GlobalVars.p6ranged or GlobalVars.p6magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("up") and not vis and GlobalVars.player6Mode and GlobalVars.player6Current:
		position.y -= 16
		if GlobalVars.p6melee or GlobalVars.p6ranged or GlobalVars.p6magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("down") and not vis and GlobalVars.player6Mode and GlobalVars.player6Current:
		position.y += 16
		if GlobalVars.p6melee or GlobalVars.p6ranged or GlobalVars.p6magic: moveCheck()
		else: checkPos(position.x, position.y, currentX, currentY)
	elif Input.is_action_just_pressed("enter") and not vis and GlobalVars.player6Mode and GlobalVars.player6Current and (GlobalVars.p6melee or GlobalVars.p6ranged or GlobalVars.p6magic):
		damageCheck()
		position.x = ogposX
		position.y = ogposY
		GlobalVars.meleeMode = false
		GlobalVars.rangedMode = false
		GlobalVars.magicMode = false
		GlobalVars.p6melee = false
		GlobalVars.p6ranged = false
		GlobalVars.p6magic = false
		GlobalVars.player6Current = false
		GlobalVars.player6Mode = false
		GlobalVars.optionMode = false
	elif Input.is_action_just_pressed("menu") and not vis and GlobalVars.player6Mode and GlobalVars.player6Current:
		z_index = 1
		GlobalVars.optionMode = true
		if GlobalVars.p6melee or GlobalVars.p6ranged or GlobalVars.p6magic:
			position.x = ogposX
			position.y = ogposY
			GlobalVars.p6melee = false
			GlobalVars.p6ranged = false
			GlobalVars.p6magic = false
			GlobalVars.meleeMode = false
			GlobalVars.rangedMode = false
			GlobalVars.magicMode = false
			movXneg = rmovXneg
			movXpos = rmovXpos
			movYpos = rmovYpos
			movYneg = rmovYneg
		ui.visible = true
	elif Input.is_action_just_pressed("melee") and vis and GlobalVars.player6Mode and GlobalVars.player6Current:
		GlobalVars.p6melee = true
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
	elif Input.is_action_just_pressed("ranged") and vis and GlobalVars.player6Mode and GlobalVars.player6Current:
		GlobalVars.p6ranged = true
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
	elif Input.is_action_just_pressed("magic") and vis and GlobalVars.player6Mode and GlobalVars.player6Current:
		#need to get this finished
		pass
	elif Input.is_action_just_pressed("endturn") and vis and GlobalVars.player6Mode and GlobalVars.player6Current:
		ui.visible = false
		GlobalVars.meleeMode = false
		GlobalVars.rangedMode = false
		GlobalVars.magicMode = false
		GlobalVars.p6melee = false
		GlobalVars.p6ranged = false
		GlobalVars.p6magic = false
		GlobalVars.player6Mode = false
		GlobalVars.player6Current = false
		GlobalVars.optionMode = false
	elif Input.is_action_just_pressed("menu") and vis and GlobalVars.player6Mode and GlobalVars.player6Current:
		z_index = 0
		ui.visible = false
		GlobalVars.meleeMode = false
		GlobalVars.rangedMode = false
		GlobalVars.magicMode = false
		GlobalVars.p6melee = false
		GlobalVars.p6ranged = false
		GlobalVars.p6magic = false
		GlobalVars.optionMode = false
