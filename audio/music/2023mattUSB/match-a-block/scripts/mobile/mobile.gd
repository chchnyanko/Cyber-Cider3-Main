extends Node2D

var score = 0
var frame = [[0 , 0 , 0 , 0 , 0],
[0 , 0 , 0 , 0 , 0],
[0 , 0 , 0 , 0 , 0],
[0 , 0 , 0 , 0 , 0],
[0 , 0 , 0 , 0 , 0]]
var h = 0
var v = 0

func _ready():
	randomize()
	frame = [[randi()%4+1 , randi()%4+1 , randi()%4+1 , randi()%4+1 , randi()%4+1],
[randi()%4+1 , randi()%4+1 , randi()%4+1 , randi()%4+1 , randi()%4+1],
[randi()%4+1 , randi()%4+1 , randi()%4+1 , randi()%4+1 , randi()%4+1],
[randi()%4+1 , randi()%4+1 , randi()%4+1 , randi()%4+1 , randi()%4+1],
[randi()%4+1 , randi()%4+1 , randi()%4+1 , randi()%4+1 , randi()%4+1]]
	score = 0

func changev():
	if frame[0][v-1] == 0:
		score += 100
	if frame[0][v-1] == 1:
		score += 10
	if frame[0][v-1] == 2:
		score += 15
	if frame[0][v-1] == 3:
		score += 25
	if frame[0][v-1] == 4:
		score += 50
	randomize()
	frame[0][v-1] = randi()%4+1
	frame[1][v-1] = randi()%4+1
	frame[2][v-1] = randi()%4+1
	frame[3][v-1] = randi()%4+1
	frame[4][v-1] = randi()%4+1
	v = 0

func changeh():
	if frame[h-1][0] == 0:
		score += 100
	if frame[h-1][0] == 1:
		score += 10
	if frame[h-1][0] == 2:
		score += 15
	if frame[h-1][0] == 3:
		score += 20
	if frame[h-1][0] == 4:
		score += 50
	randomize()
	frame[h-1][0] = randi()%4+1
	frame[h-1][1] = randi()%4+1
	frame[h-1][2] = randi()%4+1
	frame[h-1][3] = randi()%4+1
	frame[h-1][4] = randi()%4+1
	h = 0

func _process(delta):
	if not v == 0:
		changev()
	if not h == 0:
		changeh()
	if frame[0][0] == frame[0][1] and frame[0][0] == frame[0][2] and frame[0][0] == frame[0][3] and frame[0][0] == frame[0][4]:
		h = 1
	if frame[1][0] == frame[1][1] and frame[1][0] == frame[1][2] and frame[1][0] == frame[1][3] and frame[1][0] == frame[1][4]:
		h = 2
	if frame[2][0] == frame[2][1] and frame[2][0] == frame[2][2] and frame[2][0] == frame[2][3] and frame[2][0] == frame[2][4]:
		h = 3
	if frame[3][0] == frame[3][1] and frame[3][0] == frame[3][2] and frame[3][0] == frame[3][3] and frame[3][0] == frame[3][4]:
		h = 4
	if frame[4][0] == frame[4][1] and frame[4][0] == frame[4][2] and frame[4][0] == frame[4][3] and frame[4][0] == frame[4][4]:
		h = 5
	if frame[0][0] == frame[1][0] and frame[0][0] == frame[2][0] and frame[0][0] == frame[3][0] and frame[0][0] == frame[4][0]:
		v = 1
	if frame[0][1] == frame[1][1] and frame[0][1] == frame[2][1] and frame[0][1] == frame[3][1] and frame[0][1] == frame[4][1]:
		v = 2
	if frame[0][2] == frame[1][2] and frame[0][2] == frame[2][2] and frame[0][2] == frame[3][2] and frame[0][2] == frame[4][2]:
		v = 3
	if frame[0][3] == frame[1][3] and frame[0][3] == frame[2][3] and frame[0][3] == frame[3][3] and frame[0][3] == frame[4][3]:
		v = 4
	if frame[0][4] == frame[1][4] and frame[0][4] == frame[2][4] and frame[0][4] == frame[3][4] and frame[0][4] == frame[4][4]:
		v = 5
	if score < 0:
		score = 0
