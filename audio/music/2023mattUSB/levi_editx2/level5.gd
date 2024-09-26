extends Node2D

func _ready():
	sound.play_level_music()
	get_tree().paused = false
	settings.boydoor = false
	settings.girldoor = false
	$AnimatedSprite.hide()
	$nextlevel.hide()
	$home.hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene("res://level select.tscn")
	if settings.boydoor == true and settings.girldoor == true:
		settings.l6 = true
		$AnimatedSprite.show()
		$nextlevel.show()
		$home.show()
		get_tree().paused = true

func _on_nextlevel_pressed():
	get_tree().change_scene("res://level6.tscn")

func _on_home_pressed():
	get_tree().change_scene("res://title.tscn")
