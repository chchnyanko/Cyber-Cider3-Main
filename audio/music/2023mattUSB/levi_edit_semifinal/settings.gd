extends Node2D

var boydoor = false
var girldoor = false
var l2 = false
var l3 = false
var l4 = false
var l5 = false
var l6 = false
var tag = false

func _ready():
	sound.play_menu_music()

func _on_bgm_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), value)

func _on_se_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("school bus"), value)

func _on_TextureButton_pressed():
	get_tree().change_scene("res://level select.tscn")
