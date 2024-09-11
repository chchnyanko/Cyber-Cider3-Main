extends CharacterBody2D

var gravity_value = 1600
var max_gravity = 1000

var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var dash_input = false

var last_direction = Vector2.RIGHT
var speed = 1800
var jump_velocity = -530
var jumps = 0
var max_speed = 500
var buffertime = 0.2

var can_dash = true
var wall_jump_direction = 0

var current_state = null
var previous_state = null

@onready var sprite = $AnimatedSprite2D
@onready var states = $states
@onready var raycasts = $raycasts
@onready var jump = $jumpbuffer

func _process(delta):
	if str(current_state.get_name()) == "fall":
		if not sprite.animation == "fallidle":
			sprite.play("fall")
	else:
		sprite.play(str(current_state.get_name()))
	
	#physics process stuff
	player_input()
	change_state(current_state.update(delta))
	move_and_slide()

func _ready():
	for state in states.get_children():
		state.states = states
		state.player = self
	previous_state = states.idle
	current_state = states.idle

func gravity(delta):
	if not is_on_floor() and velocity.y < max_gravity:
		velocity.y += gravity_value * delta

func change_state(input_state):
	if input_state != null:
		previous_state = current_state 
		current_state = input_state
		
		previous_state.exit_state()
		current_state.enter_state()

func get_next_to_wall():
	for raycast in raycasts.get_children():
		raycast.force_raycast_update()
		if raycast.is_colliding():
			if raycast.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null

func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("right"):
		movement_input.x += 1
		if current_state.name != "dash":
			sprite.flip_h = false
	if Input.is_action_pressed("left"):
		movement_input.x -= 1
		if current_state.name != "dash":
			sprite.flip_h = true
	if Input.is_action_pressed("up"):
		movement_input.y -= 1
	if Input.is_action_pressed("down"):
		movement_input.y += 1
	
	#jump
	if Input.is_action_pressed("up"):
		jump_input = true
	else:
		jump_input = false
	if Input.is_action_just_pressed("up"):
		jump_input_actuation = true
		jump.start(buffertime)
	if Input.is_action_just_released("up"):
		jump_input_actuation = false
	
	#dash
	if Input.is_action_just_pressed("jump"):
		dash_input = true
	else:
		dash_input = false

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "fall":
		sprite.play("fallidle")

func _on_jumpbuffer_timeout():
	jump_input_actuation = false
