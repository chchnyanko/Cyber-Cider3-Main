extends Area2D

func _ready():
	$AnimatedSprite.frame = 0

func _on_button_body_entered(body):
	if body.name == "boy" or body.name == "girl":
		$StaticBody2D/AnimatedSprite.animation = "opening"
		$AnimatedSprite.frame = 1
		$StaticBody2D/CollisionShape2D.position.y += 10000

func _on_button_body_exited(body):
	if body.name == "boy" or body.name == "girl":
		$StaticBody2D/AnimatedSprite.animation = "closing"
		$AnimatedSprite.frame = 0
		$StaticBody2D/CollisionShape2D.position.y -= 10000
