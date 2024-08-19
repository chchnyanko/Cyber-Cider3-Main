extends "res://3D/player/statemachine/state.gd"


@onready var timer: Timer = $Timer
var speed: float = 50
var diving: bool = false
var divable: bool = false


func update(delta):
	if !diving:
		return states.fall


func enter_state():
	if !divable:
		return
	divable = false
	player.play_animation("dash")
	player_movement(speed)
	player.velocity.y = 10
	diving = true
	timer.start(0.2)


func exit_state():
	pass


func _on_timer_timeout() -> void:
	diving = false


func _on_yarts_landed() -> void:
	divable = true
