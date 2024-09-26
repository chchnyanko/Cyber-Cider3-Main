extends KinematicBody

var front = false
var back = false

func _on_front_area_entered(area):
	if area.name == "object":
		front = true

func _on_front_area_exited(area):
	if area.name == "object":
		front = false

func _on_back_area_entered(area):
	if area.name == "object":
		back = true

func _on_back_area_exited(area):
	if area.name == "object":
		back = false

func _physics_process(delta):
	if Input.is_action_pressed("up") and not front and translation.z > -9:
		translation.z -= 0.1
	if Input.is_action_pressed("down") and not back and translation.z < -2:
		translation.z += 0.1
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		rotate_y(0.1)
	else:
		if rotation_degrees.y > 1 and rotation_degrees.y < 359:
			rotate_y(0.1)
		else:
			rotation_degrees.y = 0
