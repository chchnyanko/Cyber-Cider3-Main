extends KinematicBody2D

var movespeed : int = 1000
var defspeed = 700
var vel : Vector2 = Vector2()
var facingDir : Vector2 = Vector2()
var speed = 0
var flip = false
var building = 0
var pause = false

func _physics_process(_delta):
	vel = Vector2()
	if position.y > 0:
		if Input.is_action_pressed("up"):
			vel.y -= 1
			facingDir = Vector2(0, -1)
	if position.y < 7040:
		if Input.is_action_pressed("down"):
			vel.y += 1
			facingDir = Vector2(0, 1)
	if position.x > 0:
		if Input.is_action_pressed("left"):
			vel.x -= 1
			facingDir = Vector2(-1, 0)
			flip = true
	if position.x < 13504:
		if Input.is_action_pressed("right"):
			vel.x += 1
			facingDir = Vector2(1, 0)
			flip = false
	if flip:
		$CollisionShape2D.set_scale(Vector2(-1, 1))
		$Sprite.set_scale(Vector2(-1, 1))
	else:
		$CollisionShape2D.set_scale(Vector2(1, 1))
		$Sprite.set_scale(Vector2(1, 1))
	vel = move_and_slide(vel.normalized()*movespeed)
	if Input.is_action_pressed("action"):
		defspeed = 900
	else:
		defspeed = 700
	if hub.pause == true:
		speed = 1000
		$Camera2D.zoom.x = 45
		$Camera2D.zoom.y = 45
	else:
		$Camera2D.zoom.x = 5
		$Camera2D.zoom.y = 5
	if building == 10:
		$AnimatedSprite.frame = 2
	elif not building == 0:
		$AnimatedSprite.frame = 1
	else:
		$AnimatedSprite.frame = 0
	if speed == 1:
		movespeed = defspeed * 2
	else:
		movespeed = defspeed
	if building == 1 and Input.is_action_just_pressed("action"):
		get_tree().change_scene("res://scenes/menu/main_menu.tscn")
	if building == 2 and Input.is_action_just_pressed("action"):
		get_tree().change_scene("res://scenes/options/options.tscn")
	if building == 3 and Input.is_action_just_pressed("action"):
		get_tree().change_scene("res://scenes/gameplay/shop.tscn")
	if building == 10 and Input.is_action_just_pressed("action"):
		get_tree().change_scene("res://scenes/gameplay/brain.tscn")


func _on_house_body_entered(body):
	if body.name == "player":
		building = 1

func _on_house_body_exited(body):
	if body.name == "player":
		building = 0

func _on_garage_body_entered(body):
	if body.name == "player":
		building = 2

func _on_garage_body_exited(body):
	if body.name == "player":
		building = 0

func _on_mineshaft_body_entered(body):
	if body.name == "player":
		building = 10

func _on_mineshaft_body_exited(body):
	if body.name == "player":
		building = 0

func _on_3_body_entered(body):
	if body.name == "player" and pause == false:
		speed = 1

func _on_3_body_exited(body):
	if body.name == "player":
		speed = 0

func _on_shop_body_entered(body):
	if body.name == "player":
		building = 3

func _on_shop_body_exited(body):
	if body.name == "player":
		building = 0

func _on_sell_body_entered(body):
	if body.name == "player":
		building = 4

func _on_sell_body_exited(body):
	if body.name == "player":
		building = 0
