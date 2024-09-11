extends Node2D

@export_range(1, 100, 1) var win_amount: int
@export_range(0.1, 3, 0.1) var time: float
@export_range(0.1, 2, 0.1) var reaction_time: float

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

const options: Array[String] = ["UP", "DOWN", "LEFT", "RIGHT"]

var selecting: bool = false
var input: int = 0
var dir
var score: int = 0
var streak: int = 0

func _ready() -> void:
	reset()

func _process(delta: float) -> void:
	if selecting:
		if Input.is_action_just_pressed("up"):
			input = 1
		if Input.is_action_just_pressed("down"):
			input = 2
		if Input.is_action_just_pressed("left"):
			input = 3
		if Input.is_action_just_pressed("right"):
			input = 4
		if input != 0:
			if input == dir:
				score += 1
				streak += 1
				if streak == win_amount:
					win()
					return
			else:
				streak = 0
				label.text = "X"
				return
			reset()

func reset():
	selecting = false
	input = 0
	timer.start(time)
	label.text = ""
	$Label2.text = str("Current score: ", score)
	$Label3.text = str("Current streak: ", streak)

func _on_timer_timeout() -> void:
	if selecting:
		reset()
		label.text = "X"
	else:
		if streak == win_amount:
			get_tree().change_scene_to_file("res://minigames/minigames.tscn")
		else:
			selecting = true
			dir = randi_range(1, 4)
			label.text = str(options[dir - 1])
			timer.start(reaction_time)
	#timer.start(time + time_rand_range)

func win() -> void:
	label.text = "You win"
	selecting = false
	timer.start(0.5)
