extends KinematicBody2D

var gravity = 2000
var speed = 400
var jump = 875
var vel = Vector2()
var onground = false
var walk = false
var idle = 0
var teleport = false
var bootleg_coyote = 0
var jumped = false

func _process(delta):
	if not settings.boydoor:
		show()
		vel.x = 0
		walk = false
		if is_on_floor() == false:
			bootleg_coyote += 1
		else:
			jumped = false
			bootleg_coyote = 0
		if Input.is_action_pressed("left1"):
			idle = 0
			walk = true
			$AnimatedSprite.flip_h = true
			vel.x -= speed
		if Input.is_action_pressed("right1"):
			idle = 0
			walk = true
			$AnimatedSprite.flip_h = false
			vel.x += speed
		if not Input.is_action_pressed("left1") or not Input.is_action_pressed("right1"):
			idle += delta
		if idle > 1:
			$AnimatedSprite.animation = "idle"
		else:
			$AnimatedSprite.animation = "walk"
		vel = move_and_slide(vel, Vector2.UP)
		vel.y += gravity * delta
		if Input.is_action_just_pressed("jump1") and is_on_floor():
			jumped = true
			vel.y = -jump
		elif Input.is_action_pressed("jump1") and bootleg_coyote <= 12 and jumped == false:
			vel.y = -jump
			jumped = true
		if $AnimatedSprite.animation == "walk" and not walk:
			$AnimatedSprite.playing = false
		else:
			$AnimatedSprite.playing = true
		if Input.is_action_pressed("crouch"):
			$CollisionShape2D.scale.y = 0.4
			$AnimatedSprite.animation = "crouch"
		else:
			$CollisionShape2D.scale.y = 1
		if not is_on_floor():
			idle = 0
			if vel.y < 0:
				$AnimatedSprite.animation = "jump"
			if vel.y > 1:
				$AnimatedSprite.animation = "fall"
		if teleport:
			if Input.is_action_just_pressed("jump1"):
				teleporter.posx = position.x
				teleporter.posy = position.y
				teleporter.girl = true
				position.x = teleporter.girlposx
				position.y = teleporter.girlposy
				vel.y = 0
		if teleporter.boy:
			position.x = teleporter.posx
			position.y = teleporter.posy
			vel.y = 0
		teleporter.boyposx = position.x
		teleporter.boyposy = position.y
	else:
		hide()

func _on_teleporter_body_entered(body):
	if body.name == "boy":
		teleport = true

func _on_teleporter_body_exited(body):
	if body.name == "boy":
		teleport = false
