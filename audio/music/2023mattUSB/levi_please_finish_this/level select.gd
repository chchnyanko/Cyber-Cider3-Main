extends Node2D

func _ready():
	get_tree().paused = false
	sound.play_menu_music()
	if settings.l2:
		$L2/Lock.hide()
	if settings.l3:
		$L3/Lock2.hide()
	if settings.l4:
		$L4/Lock3.hide()
	if settings.l5:
		$L5/Lock4.hide()
	if settings.l6:
		$L6/Lock5.hide()
	if settings.tag:
		$L7/Lock6.hide()

func _on_L1_pressed():
	get_tree().change_scene_to_file("res://level1.tscn")

func _on_L2_pressed():
	if settings.l2:
		get_tree().change_scene_to_file("res://level2.tscn")

func _on_L3_pressed():
	if settings.l3:
		get_tree().change_scene_to_file("res://level3.tscn")

func _on_L4_pressed():
	if settings.l4:
		get_tree().change_scene_to_file("res://level4.tscn")

func _on_L5_pressed():
	if settings.l5:
		get_tree().change_scene_to_file("res://level5.tscn")

func _on_L6_pressed():
	if settings.l6:
		get_tree().change_scene_to_file("res://level6.tscn")

func _on_L7_pressed():
	if settings.tag:
		get_tree().change_scene_to_file("res://tag.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")

func _on_quit_pressed():
	get_tree().quit()
