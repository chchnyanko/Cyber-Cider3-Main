extends Node

@onready var sounds: Dictionary = {
	"die": $Die,
	"fast_run": $FastRun,
	"jump": $Jump,
	"walk": $Walk
}

var current_sound: String

func play_sound(sound_name: String):
	if current_sound != sound_name:
		sounds.get(current_sound).stop()
		current_sound = sound_name
		sounds.get(sound_name).play()
