extends Node2D

func _on_colourblind_pressed():
	if set.mode < 2:
		set.mode += 1
	else:
		set.mode = 0

func _process(delta):
	if set.mode == 0:
		$button.text = "normal"
	if set.mode == 1:
		$button.text = "colourblind"
	if set.mode == 2:
		$button.text = "easy"
