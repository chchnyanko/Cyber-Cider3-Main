extends Node2D

@export_range(500, 1500, 100) var grabber_speed: int

@onready var grabber: Sprite2D = $grabber
@onready var ball: RigidBody2D = $ball
@onready var dropper: Area2D = $dropper

var current_state: int = 0
var ball_vely: float = 0

func _ready() -> void:
	dropper.position.x = randi_range(500, 1600)
	grabber.position = Vector2(100, 200)
	ball.position = Vector2(100, 800)
	ball.freeze = true

func _process(delta: float) -> void:
	if current_state == 0: #grabbing ball
		if grabber.position.y < ball.position.y:
			grabber.position.y += 10
		else:
			current_state += 1
	if current_state == 1:
		if grabber.position.y > 100:
			grabber.position.y -= 10
			ball.position.y = grabber.position.y
		else:
			current_state += 1
	if current_state == 2:
		if Input.is_action_just_pressed("jump"):
			current_state += 1
	if current_state == 3:
		if Input.is_action_just_released("jump") or grabber.position.x > 1900:
			current_state += 1
			ball.freeze = false
		grabber.position.x += grabber_speed * delta
		ball.position.x = grabber.position.x
	if current_state == 4:
		if ball.position.y > 1200:
			lose()
	print(ball.position)

func win() -> void:
	current_state += 1
	$Label.text = "You win"
	$Timer.start(0.5)

func lose() -> void:
	current_state += 1
	$Timer.start(0.5)

func _on_dropper_body_entered(body: Node2D) -> void:
	if body == ball:
		win()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://minigames/minigames.tscn")
