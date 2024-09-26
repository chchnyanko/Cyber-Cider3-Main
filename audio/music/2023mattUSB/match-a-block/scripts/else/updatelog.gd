extends Node2D

var state = 0
var show = 0

func _process(delta):
	if show == 0:
		$full.show()
	else:
		$full.hide()
	if show == 1:
		$a01.show()
	else:
		$a01.hide()
	if show == 2:
		$a02.show()
	else:
		$a02.hide()
	if show == 3:
		$a03.show()
	else:
		$a03.hide()
	if show == 4:
		$a04.show()
	else:
		$a04.hide()
	if show == 5:
		$a05.show()
	else:
		$a05.hide()
	if show == 6:
		$a06.show()
	else:
		$a06.hide()
	if state < 7:
		if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("right"):
			$AnimatedSprite.show()
			state += 1
	if state > 0:
		if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("left"):
			$AnimatedSprite.show()
			state -= 1
	if Input.is_action_just_pressed("next"):
		show = state - 1
		if state == 0:
			get_tree().change_scene("res://scenes/menu/main_menu.tscn")
	if Input.is_action_just_pressed("back"):
		get_tree().change_scene("res://scenes/menu/main_menu.tscn")
	if state == 0:
		$AnimatedSprite.position.x = 13
	if state == 1:
		$AnimatedSprite.position.x = 50
	if state == 2:
		$AnimatedSprite.position.x = 91
	if state == 3:
		$AnimatedSprite.position.x = 125
	if state == 4:
		$AnimatedSprite.position.x = 161
	if state == 5:
		$AnimatedSprite.position.x = 195
	if state == 6:
		$AnimatedSprite.position.x = 230
	if state == 7:
		$AnimatedSprite.position.x = 267

func _ready():
	show = 0

func _on_a01b_pressed():
	show = 1

func _on_a02b_pressed():
	show = 2

func _on_a03b_pressed():
	show = 3

func _on_a04b_pressed():
	show = 4

func _on_full_pressed():
	show = 0

func _on_a05b_pressed():
	show = 5

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/menu/main_menu.tscn")

func _on_a06b_pressed():
	show = 6
