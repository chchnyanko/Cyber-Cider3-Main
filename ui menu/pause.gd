extends Control

@onready var animation = $"../AnimationPlayer"

func toggle_pause():
	var paused = get_tree().paused
	get_tree().paused = !paused
	if paused:
		animation.play("unpause")
		if get_tree().current_scene.name == "City":
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		animation.play("pause")
		if get_tree().current_scene.name == "City":
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var focus = get_viewport().gui_get_focus_owner()
	if focus:
		focus.release_focus()

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
