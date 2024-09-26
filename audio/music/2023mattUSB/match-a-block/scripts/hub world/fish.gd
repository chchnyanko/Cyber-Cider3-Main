extends Area2D

var timer = 0

func _process(delta):
	timer += delta
	if timer < 3:
		$AnimatedSprite.play("dive")
	else:
		if $AnimatedSprite.frame == 6:
			hide()
			timer = 0

func _on_Area2D_area_entered(area):
	show()

func _on_Area2D_area_exited(area):
	hide()
