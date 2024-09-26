extends Node2D

var frame = 0

func _ready():
	sound.stop_menu_music()
	$AnimatedSprite.hide()
	$score.text = str(score.score)
	$highscore.text = str(score.hiscore)
	$Sprite.frame = 0

func _process(delta):
	if frame > -10:
		frame += delta
	if frame > 1 and frame < 2:
		$Sprite.frame = 1
		frame = 3
	if frame > 4:
		$Sprite.frame = 2
	if frame > 4.5:
		$AudioStreamPlayer.playing = true
		$AnimatedSprite.show()
		frame = -100

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/gameplay/brain.tscn")
	brain._ready()

func _on_Button2_pressed():
	get_tree().change_scene("res://scenes/menu/main_menu.tscn")


func _on_Button3_pressed():
	if score.score > 500:
		score.score -= 500
		get_tree().change_scene("res://scenes/gameplay/brain.tscn")
