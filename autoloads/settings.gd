extends Node

const max_camera_distance: int = 30
const max_camera_sensitivity: float = 1
const default_camera_distance: int = 10
const default_camera_sensitivity: float = 0.2
const default_player_visibility: float = 0.8

var fullscreen: bool:
	get():
		return fullscreen
	set(value):
		fullscreen = value
		if value == true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

var camera_distance: int = 10:
	get():
		return camera_distance
	set(value):
		value = clampi(value, 0, max_camera_distance)
		camera_distance = value

var camera_sensitivity: float = 0.2:
	get():
		return camera_sensitivity
	set(value):
		value = clampf(value, 0.01, max_camera_sensitivity)
		camera_sensitivity = value

var player_visibility: float = 0.8:
	get():
		return player_visibility
	set(value):
		value = clampf(value, 0, 1)
		player_visibility = value

func reset() -> void:
	set("camera_distance", default_camera_distance)
	set("camera_sensitivity", default_camera_sensitivity)
	set("player_visibility", default_player_visibility)
