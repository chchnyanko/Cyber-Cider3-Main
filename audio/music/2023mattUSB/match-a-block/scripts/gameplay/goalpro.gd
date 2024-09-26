extends Label

func _process(delta):
	if set.goalyn:
		show()
		$TextureProgress.max_value = set.goal
		$TextureProgress.value = score.score
	else:
		hide()
