extends AudioStreamPlayer

@onready var label: Label = $CanvasLayer/Label
@onready var timer: Timer = $Timer

const songs: Dictionary = {
	"Cyber City Dreams": preload("res://audio/music/Cyber City Dreams.mp3"),
	"In Their Hands": preload("res://audio/music/In Their Hands.mp3"),
	"Neon Nights": preload("res://audio/music/Neon Nights.mp3"),
	"Night Prowler": preload("res://audio/music/Night Prowler.mp3"),
	"Running Through Neon Lights": preload("res://audio/music/Running Through Neon Lights.mp3"),
	"Pixel Dream": preload("res://audio/music/Pixel Dream.mp3"),
	"City Nights": preload("res://audio/music/City Nights.mp3")
}

func change_song(song_name: String = "random"):
	stop()
	if song_name == "random":
		song_name = str(songs.keys()[randi_range(0, 6)])
	stream = songs.get(song_name)
	play()
	label.text = str("♪Current song: \n", song_name)
	timer.start(10)

func _on_finished() -> void:
	if get_tree().current_scene.name == "City":
		change_song()

func _on_timer_timeout() -> void:
	label.text = ""
