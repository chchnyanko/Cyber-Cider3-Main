extends Area2D

var h = 5
var v = 5
var posy = 2
var posx = 2
var brain = [[0 , 1 , 2 , 3 , 4],
[1 , 2 , 3 , 4 , 0],
[2 , 3 , 4 , 0 , 1],
[3 , 4 , 0 , 1 , 2],
[3 , 4 , 1 , 2 , 3]]
var frame = [[0 , 1 , 2 , 3 , 4],
[1 , 2 , 3 , 4 , 0],
[2 , 3 , 4 , 0 , 1],
[3 , 4 , 0 , 1 , 2],
[3 , 4 , 1 , 2 , 3]]
var sides = [[0 , 0 , 0 , 0 , 0],
[0 , 0],
[0 , 0],
[0 , 0],
[0 , 0],
[0 , 0],
[0 , 0 , 0 , 0 , 0]]
var a02 = 30
var a11 = 31
var a12 = 50
var a21 = 51
var a22 = 70
var a31 = 71
var a32 = 90
var a41 = 91
var thing = 0

func _ready():
	sound.stop_menu_music()
	position.x = 80
	position.y = 80
	randomize()
	thing = randi()%2+1
	brain = [
	[randi()%100 , randi()%100 , randi()%100 , randi()%100 , randi()%100], # top row
	[randi()%100 , randi()%100 , randi()%100 , randi()%100 , randi()%100], #2nd row
	[randi()%100 , randi()%100 , randi()%100 , randi()%100 , randi()%100], #3rd row
	[randi()%100 , randi()%100 , randi()%100 , randi()%100 , randi()%100], #4th row
	[randi()%100 , randi()%100 , randi()%100 , randi()%100 , randi()%100]]  #bottoim row
	reset()

func reset():
	score.score = 0
	h = 2
	v = 2
	sides = [[brain[0][0] , brain[0][1] , brain[0][2] , brain[0][3] , brain[0][4]],
[brain[0][0] , brain[0][4]],
[brain[1][0] , brain[1][4]],
[brain[2][0] , brain[2][4]],
[brain[3][0] , brain[3][4]],
[brain[4][0] , brain[4][4]],
[brain[4][0] , brain[4][1] , brain[4][2] , brain[4][3] , brain[4][4]]]

func changev():
	if frame[0][v-1] == 0:
		score.score += 5 * (up.multi + 1) * 0.1
		score.money += 5 * (up.multi + 1) * 0.1
	if frame[0][v-1] == 1:
		score.score += 10 * (up.multi + 1) * 0.1
		score.money += 10 * (up.multi + 1) * 0.1
	if frame[0][v-1] == 2:
		score.score += 20 * (up.multi + 1) * 0.1
		score.money += 20 * (up.multi + 1) * 0.1
	if frame[0][v-1] == 3:
		score.score += 30 * (up.multi + 1) * 0.1
		score.money += 30 * (up.multi + 1) * 0.1
	if frame[0][v-1] == 4:
		score.score += 50 * (up.multi + 1) * 0.1
		score.money += 50 * (up.multi + 1) * 0.1
	randomize()
	brain[0][v-1] = randi()%100
	brain[1][v-1] = randi()%100
	brain[2][v-1] = randi()%100
	brain[3][v-1] = randi()%100
	brain[4][v-1] = randi()%100
	v = 0

func changeh():
	if frame[0][v-1] == 0:
		score.score += 5 * (up.multi + 1) * 0.1
		score.money += 5 * (up.multi + 1) * 0.1
	if frame[0][v-1] == 1:
		score.score += 10 * (up.multi + 1) * 0.1
		score.money += 10 * (up.multi + 1) * 0.1
	if frame[0][v-1] == 2:
		score.score += 20 * (up.multi + 1) * 0.1
		score.money += 20 * (up.multi + 1) * 0.1
	if frame[0][v-1] == 3:
		score.score += 30 * (up.multi + 1) * 0.1
		score.money += 30 * (up.multi + 1) * 0.1
	if frame[0][v-1] == 4:
		score.score += 50 * (up.multi + 1) * 0.1
		score.money += 50 * (up.multi + 1) * 0.1
	randomize()
	brain[h-1][0] = randi()%100
	brain[h-1][1] = randi()%100
	brain[h-1][2] = randi()%100
	brain[h-1][3] = randi()%100
	brain[h-1][4] = randi()%100
	h = 0

func _physics_process(delta):
	posy = (position.y - 20) / 30
	posx = (position.x - 20) / 30
	if score.score > score.hiscore:
		score.hiscore = score.score
	if not v == 0:
		changev()
	if not h == 0:
		changeh()
	if Input.is_action_just_released("up") or Input.is_action_just_released("down"):
		sides[0][posx] = brain[0][posx]
		sides[6][posx] = brain[4][posx] 
	if Input.is_action_just_released("left") or Input.is_action_just_pressed("right"):
		sides[posy + 1][0] = brain[posy][0]
		sides[posy + 1][1] = brain[posy][4]
	if get_tree().current_scene.name == "gameplay":
		if Input.is_action_pressed("action"):
			pass
		elif Input.is_action_just_pressed("down") and position.y < 140:
			position.y += 30
		elif Input.is_action_just_pressed("up") and position.y > 20:
			position.y -= 30
		elif Input.is_action_just_pressed("left") and position.x > 20:
			position.x -= 30
		elif Input.is_action_just_pressed("right") and position.x < 140:
			position.x += 30
	if get_tree().current_scene.name == "gameplay":
		if Input.is_action_pressed("action"):
			if Input.is_action_just_pressed("down"):
				sound.play_move_sound()
				brain[4][posx] = brain[3][posx]
				brain[3][posx] = brain[2][posx]
				brain[2][posx] = brain[1][posx]
				brain[1][posx] = brain[0][posx]
				brain[0][posx] = sides[6][posx]
			if Input.is_action_just_pressed("up"):
				sound.play_move_sound()
				brain[0][posx] = brain[1][posx]
				brain[1][posx] = brain[2][posx]
				brain[2][posx] = brain[3][posx]
				brain[3][posx] = brain[4][posx]
				brain[4][posx] = sides[0][posx]
			if Input.is_action_just_pressed("left"):
				sound.play_move_sound()
				brain[posy][0] = brain[posy][1]
				brain[posy][1] = brain[posy][2]
				brain[posy][2] = brain[posy][3]
				brain[posy][3] = brain[posy][4]
				brain[posy][4] = sides[posy + 1][0]
			if Input.is_action_just_pressed("right"):
				sound.play_move_sound()
				brain[posy][4] = brain[posy][3]
				brain[posy][3] = brain[posy][2]
				brain[posy][2] = brain[posy][1]
				brain[posy][1] = brain[posy][0]
				brain[posy][0] = sides[posy + 1][1]
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
	if score.score < 0:
		score.score = 0

