extends Node2D

var spawnlev = 0
var spawn = 0
var multi = 0
var timer = 0

func _ready():
	spawnlev = up.spawn
	$AudioStreamPlayer.playing = true
	sound.stop_menu_music()

func _process(delta):
	if Input.is_action_just_pressed("cheat"):
		score.money += 1000000
	timer = up.slow * 100 + 500
	multi = up.multi * 50 + 100
	$timerlevel.text = str("level: ", int(up.slow))
	$timerbutton.text = str("$", int(timer))
	$money.text = str("$" , int(score.money))
	$level.text = str("level: ", int(spawnlev - 1))
	$multibutton.text = str("$", int(multi))
	$multilevel.text = str("level: ", int(up.multi))
	if spawnlev < 11 and spawnlev > 0:
		$Button.text = str("$", int(spawn))
	else:
		$Button2.rect_position.x = 43
		$Button.rect_position.x = 99999
	if up.slow == 15:
		$timerbutton.rect_position.x = 99999
		$Button3.rect_position.x = 145
	up.spawn = spawnlev
	up.b1 = up.a2 + 1
	up.c1 = up.b2 + 1
	up.d1 = up.c2 + 1
	up.e1 = up.d2 + 1
	if spawnlev == 0:
		spawn = 100
		up.a2 = 40
		up.b2 = 70
		up.c2 = 90
		up.d2 = 99
	if spawnlev == 1:
		spawn = 150
		up.a2 = 38
		up.b2 = 67
		up.c2 = 87
		up.d2 = 99
	if spawnlev == 2:
		spawn = 200
		up.a2 = 36
		up.b2 = 64
		up.c2 = 84
		up.d2 = 98
	if spawnlev == 3:
		spawn = 300
		up.a2 = 34
		up.b2 = 61
		up.c2 = 81
		up.d2 = 97
	if spawnlev == 4:
		spawn = 400
		up.a2 = 32
		up.b2 = 58
		up.c2 = 78
		up.d2 = 96
	if spawnlev == 5:
		spawn = 500
		up.a2 = 30
		up.b2 = 55
		up.c2 = 75
		up.d2 = 95
	if spawnlev == 6:
		spawn = 750
		up.a2 = 28
		up.b2 = 52
		up.c2 = 72
		up.d2 = 94
	if spawnlev == 7:
		spawn = 1000
		up.a2 = 26
		up.b2 = 49
		up.c2 = 69
		up.d2 = 93
	if spawnlev == 8:
		spawn = 1250
		up.a2 = 24
		up.b2 = 46
		up.c2 = 66
		up.d2 = 92
	if spawnlev == 9:
		spawn = 1500
		up.a2 = 22
		up.b2 = 43
		up.c2 = 63
		up.d2 = 91
	if spawnlev == 10:
		spawn = 2000
		up.a2 = 20
		up.b2 = 40
		up.c2 = 60
		up.d2 = 90
	$TextureProgress.value = up.b1
	$TextureProgress2.value = up.c1
	$TextureProgress3.value = up.d1
	$TextureProgress4.value = up.e1

func _on_Button_pressed():
	if score.money > spawn and spawnlev < 11:
		score.money -= spawn
		spawnlev += 1
		sound.play_money_sound()

func _on_multibutton_pressed():
	if score.money > multi:
		score.money -= multi
		up.multi += 1
		sound.play_money_sound()

func _on_timerbutton_pressed():
	if score.money > timer and up.slow < 15:
		score.money -= timer
		up.slow += 1
		sound.play_money_sound()

func _on_hub_pressed():
	get_tree().change_scene("res://scenes/hub world/hubworld.tscn")
