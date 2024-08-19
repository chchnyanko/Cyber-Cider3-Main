extends "res://3D/player/statemachine/state.gd"


@onready var timer: Timer = $Timer
const jump_time: float = 0.1
var jumping: bool = false


func update(delta):
	if !jumping:
		return states.climb


func enter_state():
	player.play_animation("walljump")
	climb()
	player.velocity.y = climb_speed * 5
	jumping = true
	timer.start(jump_time)


func exit_state():
	pass


func _on_timer_timeout() -> void:
	jumping = false
