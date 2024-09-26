extends Node2D

func _process(delta):
	if $boy.position.x > 3201:
		$boy/Camera2D.zoom.x = 0.4
		$boy/Camera2D.zoom.y = 0.4
		$boy/Camera2D.limit_right = 4032
		sound.play_dominic_music()
	else:
		$boy/Camera2D.limit_right = 3136
		$boy/Camera2D.zoom.x = 1.4
		$boy/Camera2D.zoom.y = 1.4

func _on_Area2D_body_entered(body):
	if body.name == "girl" and not teleporter.boy and not teleporter.girl:
		get_tree().paused = true
		$AnimatedSprite2D.show()
		$nextlevel.show()

func _on_dominicbutton_pressed():
	settings.tag = true
	get_tree().change_scene_to_file("res://tag.tscn")

func _on_dominic_body_entered(body):
	if body.name == "boy":
		$dominictext.show()
		$dominicbutton.show()
