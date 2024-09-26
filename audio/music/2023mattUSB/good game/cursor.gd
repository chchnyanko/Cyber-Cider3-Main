extends Area2D

var cursor_posx = 250
var cursor_posy = 175

func _ready():
	position.x = 250
	position.y = 175

func _physics_process(delta):
	cursor_posx = position.x
	cursor_posy = position.y
	if time.state == 0:
		if Input.is_action_pressed("action"):
			pass
		elif Input.is_action_just_pressed("up") and position.y >  100:
			position.y -= 50
		elif Input.is_action_just_pressed("down") and position.y <  275:
			position.y += 50
		elif Input.is_action_just_pressed("left") and position.x >  150:
			position.x -= 50
		elif Input.is_action_just_pressed("right") and position.x <  350:
			position.x += 50

