extends Node2D

@export_range(1, 100, 1) var win_amount: int
@export_range(0.1, 3, 0.1) var time: float
@export_range(0.1, 2, 0.1) var reaction_time: float


@onready var cat: AnimatedSprite2D = $cat
@onready var timer: Timer = $Timer
@onready var simon: AnimatedSprite2D = $simon
@onready var label: Label = $Label
@onready var fail: AnimatedSprite2D = $fail

var dir
var score: int = 0
var streak: int = 0
var selecting: bool = false
var lost: bool = false
var input: int = 0

const options: Array[String] = ["up", "down", "left", "right"]

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
				cat.play(options[input - 1])
				simon.play("idle")
				score += 1
				streak += 1
				if streak == win_amount:
					win()
					return
			elif !lost:
				lose()
				return
			reset()

func _on_cat_animation_finished() -> void:
	cat.play("idle")

func lose():
	fail.show()
	fail.play("kaboom")
	timer.start(0.75)
	lost = true

func _on_timer_timeout() -> void:
	if lost:
		if unlocks.cube_1_6:
			get_tree().change_scene_to_file("res://minigames/minigames.tscn")
		else:
			get_tree().change_scene_to_file("res://3D/city.tscn")
	if selecting:
		reset()
	else:
		if streak == win_amount:
			if unlocks.cube_1_6:
				get_tree().change_scene_to_file("res://minigames/minigames.tscn")
			else:
				unlocks.cubes += 1
				unlocks.cube_1_6 = true
				get_tree().change_scene_to_file("res://3D/city.tscn")
		else:
			selecting = true
			dir = randi_range(1, 4)
			simon.play(str(options[dir - 1]))
			timer.start(reaction_time)
	#timer.start(time + time_rand_range)

func _ready() -> void:
	reset()

func reset():
	selecting = false
	input = 0
	timer.start(time)
	simon.play("idle")

func win() -> void:
	label.text = "You win"
	selecting = false
	timer.start(0.5)
