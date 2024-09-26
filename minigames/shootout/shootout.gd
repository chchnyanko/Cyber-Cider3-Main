extends Node2D

@export_range(1, 100, 1) var score_to_win: int = 1
@export_range(1, 100, 1) var targets_to_spawn_at_once: int = 1 ## The number of targets to spawn at one time

@onready var target = preload("res://minigames/shootout/shootout_target.tscn")
@onready var timer: Timer = $Timer
@onready var gun: Sprite2D = $Gun
@onready var camera_2d: Camera2D = $Camera2D
@onready var animation: AnimationPlayer = $AnimationPlayer

var won: bool = false
var score: int = 0
var targets_on_screen: float = 0

func _ready() -> void:
	spawn_targets(targets_to_spawn_at_once)

func win() -> void:
	won = true
	timer.start(0.5)

func spawn_targets(amount: int = 1) -> void:
	for i in amount:
		var target_inst: Area2D = target.instantiate()
		add_child(target_inst)
		target_inst.initiate()
		target_inst.name = str("target", i + 1)
		target_inst.hit.connect(hit.bind(target_inst))
		targets_on_screen += 1

func hit(target: Area2D) -> void:
	target.queue_free()
	targets_on_screen -= 1
	score += 1
	if score >= score_to_win:
		win()
	if targets_on_screen < targets_to_spawn_at_once / 2:
		spawn_targets(targets_to_spawn_at_once)

func _on_timer_timeout() -> void:
	if won:
		get_tree().change_scene_to_file("res://minigames/minigames.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed == true:
			animation.play("gunshot")
