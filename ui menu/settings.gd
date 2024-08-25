extends Node2D

@onready var camera_distance: Label = $camera_distance
@onready var camera_distance_bar: HSlider = $camera_distance_bar

@onready var camera_sensitivity: Label = $camera_sensitivity
@onready var camera_sensitivity_bar: HSlider = $camera_sensitivity_bar

@onready var player_visibility: Label = $player_visibility
@onready var player_visibility_bar: HSlider = $player_visibility_bar

func _ready() -> void:
	camera_distance_bar.value = settings.get("camera_distance")
	camera_sensitivity_bar.value = settings.get("camera_sensitivity")
	player_visibility_bar.value = settings.get("player_visibility")
	camera_distance.text = str("Camera Distance: ", camera_distance_bar.value)
	camera_sensitivity.text = str("Camera Sensitivity: ", camera_sensitivity_bar.value)
	player_visibility.text = str("Player Visibility:", player_visibility_bar.value)

func _on_fullscreen_pressed() -> void:
	settings.set("fullscreen", !settings.get("fullscreen"))


func _on_camera_distance_bar_value_changed(value: float) -> void:
	settings.set("camera_distance", value)
	camera_distance.text = str("Camera Distance: ", value)


func _on_camera_sensitivity_bar_value_changed(value: float) -> void:
	settings.set("camera_sensitivity", value)
	camera_sensitivity.text = str("Camera Sensitivity: ", value)


func _on_player_visibility_bar_value_changed(value: float) -> void:
	settings.set("player_visibility", value)
	player_visibility.text = str("Player Visibility: ", value)


func _on_back_pressed() -> void:
	data.save_settings()


func _on_reset_pressed() -> void:
	settings.reset()
	camera_distance_bar.value = settings.get("camera_distance")
	camera_sensitivity_bar.value = settings.get("camera_sensitivity")
	camera_distance.text = str("Camera Distance: ", camera_distance_bar.value)
	camera_sensitivity.text = str("Camera Sensitivity: ", camera_sensitivity_bar.value)
	player_visibility_bar.value = settings.get("player_visibility")
	player_visibility.text = str("Player Visibility:", player_visibility_bar.value)
