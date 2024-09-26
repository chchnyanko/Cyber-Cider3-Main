extends Sprite

func _process(delta):
	if set.mode == 1:
		hide()
	else:
		show()
