extends "res://3D/player/statemachine/state.gd"


@onready var coyote_timer: Timer = $coyote_timer
@onready var jump_buffer_timer: Timer = $jump_buffer_timer

const speed: float = 12
const coyote_time: float = 0.2
const jump_buffer_time: float = 0.1

var can_jump: bool = false
var jump_input: bool = false


func update(delta):
	player_rotation()
	player_gravity(delta)
	player_movement(speed)
	
	if Input.is_action_just_pressed("jump"):
		jump_input = true
		jump_buffer_timer.start(jump_buffer_time)
	
	if can_jump and Input.is_action_just_pressed("jump") or jump_input and player.is_on_floor():
		return states.jump
	if player.is_on_floor():
		return states.idle
	if player.is_on_wall():
		return states.climb
	if player.input_dir != Vector2.ZERO and Input.is_action_just_pressed("crawl"):
		return states.dive


func enter_state():
	player.play_animation("fall")
	if player.previous_state != states.jump and player.previous_state != states.climb_jump:
		coyote_timer.start(coyote_time)
		can_jump = true


func exit_state():
	pass


func _on_coyote_timer_timeout() -> void:
	can_jump = false


func _on_jump_buffer_timer_timeout() -> void:
	jump_input = false
