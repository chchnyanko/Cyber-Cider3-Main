extends StaticBody2D

func _ready():
	show()
	#$CollisionShape2D.disabled = false

func _on_key_body_entered(body):
	if body.name == "boy" or body.name == "girl":
		$key.position.y += 10000
		$AnimatedSprite2D.animation = "opening"
		$dominic.position.y -= 10000

func _on_area2d_body_entered(body):
	if body.name == "boy" or body.name == "girl":
		$key/AnimatedSprite2D.animation = "key"

func _on_area2d_body_exited(body):
	if body.name == "boy" or body.name == "girl":
		$key/AnimatedSprite2D.animation = "rgb"
