extends Node2D

func _ready():
	sound.play_level_music()
	get_tree().paused = false
	settings.boydoor = false
	settings.girldoor = false
	$character/AnimatedSprite2D.hide()
	$character/nextlevel.hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://level select.tscn")

func _on_nextlevel_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")
