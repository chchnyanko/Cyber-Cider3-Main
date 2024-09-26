extends AnimatedSprite

var posy = 0 
var posx = 0
var thing = 0

func _ready():
	posy = (position.y - 20) / 30
	posx = (position.x - 20) / 30

func _process(delta):
	if brain.brain[posy][posx] < up.a2:
		frame = 0
	if brain.brain[posy][posx] < up.b2 and brain.brain[posy][posx] > up.b1:
		frame = 1
	if brain.brain[posy][posx] < up.c2 and brain.brain[posy][posx] > up.c1:
		frame = 2
	if brain.brain[posy][posx] < up.d2 and brain.brain[posy][posx] > up.d1:
		frame = 3
	if brain.brain[posy][posx] > up.e1:
		frame = 4
	brain.frame[posy][posx] = frame
	#frame = brain.brain[posy][posx]
	if set.mode == 0:
		if brain.thing == 1:
			play("ores")
		if brain.thing == 2:
			play("gem")
	if set.mode == 1:
		play("colourblind")
	if set.mode == 2:
		play("easy")
