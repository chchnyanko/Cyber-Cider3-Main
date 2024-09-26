extends Node2D

var tag = 0

func _process(delta):
	if Input.is_action_just_pressed("cheat"):
		settings.l2 = true
		settings.l3 = true
		settings.l4 = true
		settings.l5 = true
		settings.l6 = true
		settings.tag = true

func _ready():
	get_tree().paused = false
	sound.play_menu_music()

func _on_L1_pressed():
	get_tree().change_scene("res://level1.tscn")

func _on_L2_pressed():
	if settings.l2:
		get_tree().change_scene("res://level2.tscn")

func _on_L3_pressed():
	if settings.l3:
		get_tree().change_scene("res://level3.tscn")

func _on_L4_pressed():
	if settings.l4:
		get_tree().change_scene("res://level4.tscn")

func _on_L5_pressed():
	if settings.l5:
		get_tree().change_scene("res://level5.tscn")

func _on_L6_pressed():
	if settings.l6:
		get_tree().change_scene("res://level6.tscn")

func _on_L7_pressed():
	if settings.tag:
		get_tree().change_scene("res://tag.tscn")

func _on_settings_pressed():
	get_tree().change_scene("res://settings.tscn")

func _on_quit_pressed():
	get_tree().quit()
