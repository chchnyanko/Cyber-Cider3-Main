extends Node2D

var menu = 0
var menubgm = load("res://music/menubgm.wav")

var movese = load("res://music/swoosh.wav")
var money = load("res://music/money.wav")

func play_move_sound():
	$sound.stream = movese
	$sound.play()

func play_money_sound():
	$sound.stream = money
	$sound.play()

func play_menu_music():
	if menu == 0:
		menu = 1
		$sound.stream = menubgm
		$sound.play()

func stop_menu_music():
	$sound.stop()
	menu = 0
