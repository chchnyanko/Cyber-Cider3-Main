extends CharacterBody2D

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
			$AnimatedSprite2D.flip_h = true
			vel.x -= speed
		if Input.is_action_pressed("right1"):
			idle = 0
			walk = true
			$AnimatedSprite2D.flip_h = false
			vel.x += speed
		if not Input.is_action_pressed("left1") and not Input.is_action_pressed("right1"):
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
		if Input.is_action_just_pressed("jump1") and is_on_floor():
			jumped = true
			vel.y = -jump
			sound.jump()
		elif Input.is_action_pressed("jump1") and bootleg_coyote <= 12 and jumped == false:
			vel.y = -jump
			jumped = true
		if $AnimatedSprite2D.animation == "walk" and not walk:
			$AnimatedSprite2D.playing = false
		else:
			$AnimatedSprite2D.playing = true
		if Input.is_action_pressed("crouch"):
			$CollisionShape2D.scale.y = 0.4
			$AnimatedSprite2D.animation = "crouch"
		else:
			$CollisionShape2D.scale.y = 1
		if not is_on_floor():
			idle = 0
			if vel.y < 0 and not Input.is_action_pressed("crouch"):
				$AnimatedSprite2D.animation = "jump"
			if vel.y > 1 and not Input.is_action_pressed("crouch"):
				$AnimatedSprite2D.animation = "fall"
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

func _on_teleporter2_body_entered(body):
	if body.name == "boy":
		teleport = true

func _on_teleporter2_body_exited(body):
	if body.name == "boy":
		teleport = false
