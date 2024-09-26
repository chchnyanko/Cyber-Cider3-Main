extends Node2D

var levelbgm = load("res://sound/Everyone Is So Alive Background Music.mp3")
var tagbgm = load("res://sound/Funky Precussions Background Music.mp3")
var dominicmusic = load("res://sound/Cottage Core Background Music.mp3")
var menubgm = load("res://sound/Documentry Type Background Music.mp3")
var jump = load("res://sound/Jump Sound.mp3")
var door = load("res://sound/Open Doors Sound.mp3")

func play_level_music():
	if not $bgm.stream == levelbgm:
		$bgm.stream = levelbgm
		$bgm.play()

func play_tag_music():
	if not $bgm.stream == tagbgm:
		$bgm.stop()
		$bgm.stream = tagbgm
		$bgm.play()

func play_dominic_music():
	if not $bgm.stream == dominicmusic:
		$bgm.stream == dominicmusic
		$bgm.play()

func play_menu_music():
	if not $bgm.stream == menubgm:
		$bgm.stop()
		$bgm.stream = menubgm
		$bgm.play()

func jump():
	$sfx.stream = jump
	$sfx.play()

func door():
	$sfx.stream = door
	$sfx.play()
