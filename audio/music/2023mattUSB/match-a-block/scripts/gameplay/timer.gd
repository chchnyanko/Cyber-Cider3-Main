extends Node2D

var speed = 0

func _ready():
	if set.mode == 0:
		speed = 0.001 * (1 - up.slow * 0.05)
	if set.mode == 1:
		speed = 0.0008 * (1 - up.slow * 0.05)
	if set.mode == 2:
		speed = 0.0001 * (1 - up.slow * 0.05)

func reset():
	$timer/PathFollow2D.unit_offset = 0
	$cb/cbtimer/PathFollow2D.unit_offset = 0
	speed *= 1.05

func _process(delta):
	if set.goalyn:
		if score.score > set.goal:
			get_tree().change_scene("res://scenes/gameplay/win.tscn")
	if not set.mode == 1:
		$cb.hide()
		$timer.show()
		$timer/PathFollow2D.unit_offset += speed
		if $timer/PathFollow2D.unit_offset > 0.98:
			get_tree().change_scene("res://scenes/gameplay/lose.tscn")
	else:
		$cb.show()
		$timer.hide()
		$cb/cbtimer/PathFollow2D.unit_offset += speed
		if $cb/cbtimer/PathFollow2D.unit_offset > 0.98:
			get_tree().change_scene("res://scenes/gameplay/lose.tscn")
	if not brain.v == 0 or not brain.h == 0:
		reset()


func _on_Button_pressed():
	speed = 0.1
