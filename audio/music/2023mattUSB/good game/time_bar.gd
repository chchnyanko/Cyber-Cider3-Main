extends Sprite

var speed = 0.5
var start_pos = 0
var state = 0

func _ready():
	start_pos = position

func _process(delta):
	if position.x > -500:
		position.x -= speed
	elif position.x > -750:
		timeup()
	if Input.is_action_just_pressed("debug_1"):
		back()
	if Input.is_action_just_pressed("debug_2"):
		speedup()
	if Input.is_action_just_pressed("debug_9"):
		speed = 0

func timeup():
	print ("time up")
	position.x = -751
	speed = 0
	state = 1

func speedup():
	speed *= 1.05

func back():
	position = start_pos
