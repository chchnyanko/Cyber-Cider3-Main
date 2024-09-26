extends Area2D

var X = 0
var Y = 0
var pos = 0
var c1 = 0
var c2 = 0
var c3 = 0
var c4 = 0
var c5 = 0
var c6 = 0
var c7 = 0

func _physics_process(delta):
	if position.x < 150:
		position.x = 350
	if position.x > 350:
		position.x = 150
	if position.y < 75:
		position.y = 275
	if position.y > 275:
		position.y = 75
	if Input.is_action_pressed("action"):
		if Cursor.cursor_posx == position.x:
			if Input.is_action_just_pressed("up"):
				position.y -= 50
			elif Input.is_action_just_pressed("down"):
				position.y += 50
		if Cursor.cursor_posy == position.y:
			if Input.is_action_just_pressed("left"):
				position.x -= 50
			elif Input.is_action_just_pressed("right"):
				position.x += 50

func _process(delta):
	X = (position.x - 100) / 50
	Y = (position.y - 25) / 50
	if Input.is_action_just_pressed("debug_3"):
		if pos == 1:
			print ("____")
		if not c1 == 0:
			print (c1)
		if not c2 == 0:
			print (c2)
		if not c3 == 0:
			print (c3)
		if not c4 == 0:
			print (c4)
		if not c5 == 0:
			print (c5)
		if not c6 == 0:
			print (c6)
		if not c7 == 0:
			print (c7)
	pos = X + 5 * (Y - 1)
	if pos == 1:
		c1 = $Sprite.colour
	if pos == 2:
		c2 = $Sprite.colour
	if pos == 3:
		c3 = $Sprite.colour
	if pos == 4:
		c4 = $Sprite.colour
	if pos == 5:
		c5 = $Sprite.colour
	if pos == 6:
		c6 = $Sprite.colour
	if pos == 7:
		c7 = $Sprite.colour


#func detect(delta):
#	if Block.c1 == Block.c2 == Block.c3 == Block.c4 == Block.c5:
#		print ("top row cleared")
