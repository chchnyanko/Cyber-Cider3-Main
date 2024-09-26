extends Area2D

var onoff = 0
var timer = 0

func _ready():
	$StaticBody2D2/CollisionShape2D.position.y += 10000

func _on_lever_body_entered(body):
	if body.name == "boy" or body.name == "girl":
		if onoff == 0:
			$StaticBody2D/AnimatedSprite2D.animation = "opening"
			$StaticBody2D2/AnimatedSprite2D.animation = "closing"
			timer = 0.01
			onoff = 2
			$StaticBody2D/CollisionShape2D.position.y += 10000
			$StaticBody2D2/CollisionShape2D.position.y -= 10000
		elif onoff == 2:
			$StaticBody2D2/AnimatedSprite2D.animation = "opening"
			$StaticBody2D/AnimatedSprite2D.animation = "closing"
			timer = 0.01
			onoff = 0
			$StaticBody2D/CollisionShape2D.position.y -= 10000
			$StaticBody2D2/CollisionShape2D.position.y += 10000

func _process(delta):
	if timer == 0:
		$AnimatedSprite2D.frame = onoff
	else:
		$AnimatedSprite2D.frame = 1
	if timer > 15:
		timer = 0
	if not timer == 0:
		timer += 100 * delta
