extends Node2D

var pause = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause = !pause
	if pause:
		show()
	else:
		hide()
