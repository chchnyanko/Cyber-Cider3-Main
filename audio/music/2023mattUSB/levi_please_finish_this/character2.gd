extends CharacterBody2D

var gravity = 2000
var speed = 400
var jump = 900
var vel = Vector2()
var onground = false
var walk = false
var idle = 0
var jumps = 0
var teleport = false

func _process(delta):
	if not settings.girldoor:
		show()
		vel.x = 0
		walk = false
		if Input.is_action_pressed("left2"):
			idle = 0
			walk = true
			$AnimatedSprite2D.flip_h = true
			vel.x -= speed
		if Input.is_action_pressed("right2"):
			idle = 0
			walk = true
			$AnimatedSprite2D.flip_h = false
			vel.x += speed
		if not Input.is_action_pressed("left2") and not Input.is_action_pressed("right2"):
			idle += delta
		if idle > 1:
			$AnimatedSprite2D.animation = "idle"
		else:
			$AnimatedSprite2D.animation = "walk"
		set_velocity(vel)
		set_up_direction(Vector2.UP)
		move_and_slide()
		vel = velocity
		vel.y += gravity * delta
		if Input.is_action_just_pressed("jump2") and jumps < 1:
			vel.y = -jump
			jumps += 1
			sound.jump()
		if is_on_floor():
			jumps = 0
		if $AnimatedSprite2D.animation == "walk" and not walk:
			$AnimatedSprite2D.playing = false
		else:
			$AnimatedSprite2D.playing = true
		if not is_on_floor():
			idle = 0
			if vel.y < 0:
				$AnimatedSprite2D.animation = "jump"
			if vel.y > 1:
				$AnimatedSprite2D.animation = "fall"
		if teleport:
			if Input.is_action_just_pressed("jump2"):
				teleporter.posx = position.x
				teleporter.posy = position.y
				teleporter.boy = true
				position.x = teleporter.boyposx
				position.y = teleporter.boyposy
				vel.y = 0
		if teleporter.girl:
			vel.y = 0
			position.x = teleporter.posx
			position.y = teleporter.posy
		teleporter.girlposx = position.x
		teleporter.girlposy = position.y
	else:
		hide()

func _on_teleporter_body_entered(body):
	if body.name == "girl":
		teleport = true

func _on_teleporter_body_exited(body):
	if body.name == "girl":
		teleport = false

func _on_teleporter2_body_entered(body):
	if body.name == "girl":
		teleport = true

func _on_teleporter2_body_exited(body):
	if body.name == "girl":
		teleport = false
