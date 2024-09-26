extends AnimatedSprite

var posx = 0
var posy = 0

func _process(delta):
	posy = (position.y - 20) / 30
	posx = (position.x - 20) / 30
	frame = mobile.frame[posy][posx]
