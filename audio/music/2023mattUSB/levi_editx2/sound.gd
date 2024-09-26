extends Node2D

var levelbgm = load("res://sound/Cottage Core Background Music.mp3")
var tagbgm = load("res://sound/Funky Precussions Background Music.mp3")
var menubgm = load("res://sound/Documentry Type Background Music.mp3")

func play_level_music():
	if not $bgm.stream == levelbgm:
		$bgm.stream = levelbgm
		$bgm.play()

func play_tag_music():
	if not $bgm.stream == tagbgm:
		$bgm.stream = tagbgm
		$bgm.play()

func play_menu_music():
	if not $bgm.stream == menubgm:
		$bgm.stream = menubgm
		$bgm.play()
