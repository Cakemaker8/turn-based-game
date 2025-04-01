extends Node


var eTb = []
var eTs = []
var eTm = []

var eXb = []
var eYb = []
var eXs = []
var eYs = []
var eXm = []
var eYm = []

var eHb = [0, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20]
var eHTb = [20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20]
var eHs = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
var eHTs = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
var eHm = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
var eHTm = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]

func map1ColX(playerX, playerY, prevX, _prevY):
	# World boundaries
	if playerX < 0:
		playerX = prevX
	elif playerX > 2304:
		playerX = prevX
	# Curve
	elif playerX > 384 and playerX < 448 and playerY < 144:
		playerX = prevX
	elif playerX > 480 and playerX < 560 and playerY > 32:
		playerX = prevX
	elif playerX > 592 and playerX < 656 and playerY < 144:
		playerX = prevX
	elif playerX > 384 and playerX < 656 and playerY > 176:
		playerX = prevX
	# Bridge
	elif playerX > 848 and playerX < 944 and (playerY < 80 or playerY > 112):
		playerX = prevX
	# Final bridge
	elif playerX > 1328 and playerX < 1488 and playerY < 80:
		playerX = prevX
	elif playerX > 1328 and playerX < 1520 and playerY > 112:
		playerX = prevX
	elif playerX > 1520 and playerX < 1584 and playerY > 32:
		playerX = prevX
	elif playerX > 1616 and playerX < 1680 and playerY < 160:
		playerX = prevX
	elif playerX > 1712 and playerX < 1776 and playerY > 32:
		playerX = prevX
	elif playerX > 1776 and playerX < 1936 and playerY > 176:
		playerX = prevX
	elif playerX > 1808 and playerX < 1936 and playerY < 144:
		playerX = prevX
	return playerX

func map1ColY(playerX, playerY, _prevX, prevY):
	# World boundaries
	if playerY < 0:
		playerY = prevY
	elif playerY > 192:
		playerY = prevY
	# Curve
	elif playerY < 144 and playerX > 384 and playerX < 448:
		playerY = prevY
	elif playerX > 480 and playerX < 560 and playerY > 32:
		playerY = prevY
	elif playerX > 592 and playerX < 656 and playerY < 144:
		playerY = prevY
	elif playerX > 384 and playerX < 656 and playerY > 176:
		playerY = prevY
	# Bridge
	elif playerX > 848 and playerX < 944 and (playerY < 80 or playerY > 112):
		playerY = prevY
	# Final bridge
	elif playerX > 1328 and playerX < 1488 and playerY < 80:
		playerY = prevY
	elif playerX > 1328 and playerX < 1520 and playerY > 112:
		playerY = prevY
	elif playerX > 1520 and playerX < 1584 and playerY > 32:
		playerY = prevY
	elif playerX > 1616 and playerX < 1680 and playerY < 160:
		playerY = prevY
	elif playerX > 1712 and playerX < 1776 and playerY > 32:
		playerY = prevY
	elif playerX > 1776 and playerX < 1936 and playerY > 176:
		playerY = prevY
	elif playerX > 1808 and playerX < 1936 and playerY < 144:
		playerY = prevY
	return playerY
