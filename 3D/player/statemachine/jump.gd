extends "res://3D/player/statemachine/state.gd"

@onready var jump_timer: Timer = $jump_timer

const jump_time: float = 0.2
const jump_speed: float = 20
const speed: float = 10

var jumping: bool = false


func update(delta):
	player_rotation()
	player_gravity(delta / 2)
	player_movement(speed)
	
	if Input.is_action_just_released("jump"):
		jumping = false
	
	if jumping:
		player.velocity.y += jump_speed * delta
	else:
		return states.fall
	if player.is_on_wall():
		return states.climb
	if player.input_dir != Vector2.ZERO and Input.is_action_just_pressed("crawl"):
		return states.dive


func enter_state():
	player.play_animation("jump")
	player.velocity.y = jump_speed
	jump_timer.start(jump_time)
	jumping = true


func exit_state():
	pass

func _on_jump_timer_timeout() -> void:
	jumping = false
