extends Node2D

func _ready():
	$Sprite.frame = 0
	$AudioStreamPlayer.playing = true
	sound.stop_menu_music()

func _process(delta):
	$Label2.text = str(set.goal)

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/menu/main_menu.tscn")

func _on_Button2_pressed():
	get_tree().change_scene("res://scenes/options/options.tscn")
