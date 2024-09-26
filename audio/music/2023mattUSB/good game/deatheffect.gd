extends Sprite

var speed = 0 

func _ready():
	position.x = 250
	position.y = -175

func _process(delta):
	position.y += speed
	if position.y > 175:
		position.y = 175
	if time.state == 1:
		speed = 1
		time.state = 0
	if speed < 10:
		speed *= 1.03
