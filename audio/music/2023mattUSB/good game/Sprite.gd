extends Sprite

var rand_col = 0
var colour = 0

func _ready():
	randomize()
	rand_col = rand_range(0,4)
	if rand_col < 1 and rand_col > 0:
		colour = 1 
		texture = load("red.png")
	if rand_col < 2 and rand_col > 1.01:
		colour = 2
		texture = load("yellow.jpg")
	if rand_col < 3 and rand_col > 2.01:
		colour = 3
		texture = load("blue.png")
	if rand_col < 4 and rand_col  > 3.01:
		colour = 4
		texture = load("green.png")

func clear():
	_ready()
