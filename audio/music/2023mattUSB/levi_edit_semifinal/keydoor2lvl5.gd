extends StaticBody2D

onready var initial_position = $StaticBody2D/dominic.position

func _ready():
	show()
	$AnimatedSprite2.animation = "default2"
	$StaticBody2D/dominic.position.y += 10000

func _on_key_body_entered(body):
	if body.name == "boy" or body.name == "girl":
		$key.hide()
		$AnimatedSprite.animation = "opening"
		$AnimatedSprite.frame = 0
		$dominic.position.y -= 10000
		$StaticBody2D/dominic.position = initial_position
		$AnimatedSprite2.animation = "closing"

func _on_area2d_body_entered(body):
	if body.name == "boy" or body.name == "girl":
		$key/AnimatedSprite.animation = "key"

func _on_area2d_body_exited(body):
	if body.name == "boy" or body.name == "girl":
		$key/AnimatedSprite.animation = "rgb"


func _on_AnimatedSprite2_animation_finished():
	$AnimatedSprite2.frame = 6
