extends Node2D

var state = 1

func _ready():
	sound.play_menu_music()

func _process(delta):
	if state < 4:
		if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("right"):
			show()
			state += 1
	if state > 0:
		if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("left"):
			show()
			state -= 1
	if state == 0:
		position.x = 45
		position.y = 20
		if Input.is_action_just_pressed("next"):
			get_tree().change_scene("res://scenes/else/update log.tscn")
	elif state == 1:
		position.x = 147
		position.y = 80
		if Input.is_action_just_pressed("next"):
			get_tree().change_scene("res://scenes/gameplay/brain.tscn")
	elif state == 2:
		position.x = 309
		position.y = 23
		if Input.is_action_just_pressed("next"):
			get_tree().change_scene("res://scenes/options/options.tscn")
	elif state == 3:
		position.x = 309
		position.y = 46
		if Input.is_action_just_pressed("next"):
			get_tree().change_scene("res://scenes/gameplay/shop.tscn")
	elif state == 4:
		position.x = -10
		position.y = 198
		if Input.is_action_just_pressed("next"):
			get_tree().quit()

