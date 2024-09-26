extends Area2D

@onready var initial_position = $StaticBody2D/CollisionShape2D.position
@onready var initial_position2 = $StaticBody2D3/CollisionShape2D.position

func _ready():
	$StaticBody2D/AnimatedSprite2D.animation = "default2"
	$StaticBody2D3/AnimatedSprite2D.animation = "default2"
	$AnimatedSprite2D.frame = 0
	$StaticBody2D/CollisionShape2D.position.y += 10000
	$StaticBody2D3/CollisionShape2D.position.y += 10000


func _on_button_body_entered(body):
	if body.name == "boy" or body.name == "girl":
		$StaticBody2D/AnimatedSprite2D.animation = "closing"
		$StaticBody2D3/AnimatedSprite2D.animation = "closing"
		$AnimatedSprite2D.frame = 1
		$StaticBody2D/CollisionShape2D.position = initial_position
		$StaticBody2D3/CollisionShape2D.position = initial_position
		$Timer.stop()
		$Timer.set_wait_time(1.5)

func _on_button_body_exited(body):
	if body.name == "boy" or body.name == "girl":
		$Timer.set_wait_time(1.5)
		$Timer.start()


func _on_Timer_timeout():
	$StaticBody2D/AnimatedSprite2D.animation = "opening"
	$StaticBody2D3/AnimatedSprite2D.animation = "opening"
	$AnimatedSprite2D.frame = 0
	$StaticBody2D/CollisionShape2D.position.y += 10000
	$StaticBody2D3/CollisionShape2D.position.y += 10000
