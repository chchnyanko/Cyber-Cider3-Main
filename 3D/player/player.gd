extends CharacterBody3D

class_name yarts

signal player_death
signal landed

## Stuff for state machine
@onready var statemachine: Node = $statemachine
var current_state: state
var previous_state: state

## Other variables
@export var camera_3d: camera

@onready var sprite: AnimatedSprite3D = $AnimatedSprite3D
@onready var shadow_ray: RayCast3D = $shadow_ray
@onready var shadow: Decal = $shadow
@onready var ceiling_checker: ShapeCast3D = $ceiling_checker

var input_dir: Vector2 = Vector2.ZERO
var onfloor: bool

func _ready() -> void:
	for states in statemachine.get_children():
		states.states = statemachine
		states.player = self
		states.ceiling_checker = ceiling_checker
	current_state = statemachine.idle
	if data.checkpoint_name != "none":
		position = data.checkpoint_pos
		position.y += 0.5 

func _physics_process(delta: float) -> void:
	move_and_slide()
	
	input_dir = Input.get_vector("left", "right", "up", "down")
	
	if input_dir.x < 0:
		sprite.flip_h = true
	elif input_dir.x > 0:
		sprite.flip_h = false
	
	change_state(current_state.update(delta))
	
	shadow_ray.force_raycast_update()
	shadow.global_position = shadow_ray.get_collision_point()
	
	if !is_on_floor():
		onfloor = false
	if is_on_floor() and !onfloor:
		onfloor = true
		landed.emit()
	
	if position.y < -100:
		death(true)
	
	## DEBUG PLEASE DELETE LATER
	$debug/VBoxContainer/fps.text = str("Current FPS: ", Engine.get_frames_per_second())
	$debug/VBoxContainer/position.text = str("Current Position: ", position)
	$debug/VBoxContainer/velocity.text = str("Current Velocity: ", velocity)
	$debug/VBoxContainer/state.text = str("Current State: ", current_state.name)
	$debug/VBoxContainer/animation.text = str("Current Animation: ", sprite.animation)
	$debug/VBoxContainer/camera_rotation.text = str("Camera Rotation: ", camera_3d.rotation_degrees)
	if ceiling_checker.is_colliding():
		$debug/VBoxContainer/ceiling_checker.text = str("Ceiling Checker Collision: ", ceiling_checker.get_collider(0))
	else:
		$debug/VBoxContainer/ceiling_checker.text = str("Ceiling Checker Collision: No collision")
	if Input.is_key_pressed(KEY_0):
		death()


func change_state(next_state: state, cutscene: String = "") -> void:
	if next_state == null:
		return
	previous_state = current_state
	previous_state.exit_state()
	
	current_state = next_state
	current_state.enter_state()


func play_animation(new_animation: String, play_backwards: bool = false) -> void:
	if play_backwards:
		sprite.play_backwards(new_animation)
	else:
		sprite.play(new_animation)


func death(instant: bool = false) -> void:
	if is_on_floor() or instant:
		change_state(statemachine.cut_scene, "death")
		player_death.emit()
		return
	await landed
	change_state(statemachine.cut_scene, "death")
	player_death.emit()


## DEBUG PLEASE DELETE LATER
func _on_check_button_pressed() -> void:
	$debug/VBoxContainer.visible = !$debug/VBoxContainer.visible
	$debug/CheckButton.release_focus()


func _on_unlock_all_pressed() -> void:
	$debug/VBoxContainer/unlock_all.hide()
	for i in inst_to_dict(unlocks):
		if i != "@subpath" and i != "@path":
			unlocks.set(i, true)
