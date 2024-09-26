extends Node2D

func _on_TextureButton_pressed():
	get_tree().change_scene_to_file("res://level select.tscn")

func _ready():
	sound.play_menu_music()
