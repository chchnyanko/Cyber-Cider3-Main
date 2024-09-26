extends Node2D

@export_range(1, 100, 1) var difficulty: int = 1

@onready var target = preload("res://minigames/shootout/shootout_target.tscn")
@onready var timer: Timer = $Timer
@onready var gun: Sprite2D = $Gun
@onready var camera_2d: Camera2D = $Camera2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var crosshair: AnimatedSprite2D = $crosshair
@onready var carl_jrs_parent: Node2D = $"carl jrs parent"

var won: bool = false
var score: int = 0
var phase: int = 1

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	spawn_targets(difficulty)

func _process(delta: float) -> void:
	crosshair.position = get_viewport().get_mouse_position()

func win() -> void:
	won = true
	timer.start(0.5)

func spawn_targets(amount: int = 1) -> void:
	for i in amount:
		var target_inst: Area2D = target.instantiate()
		carl_jrs_parent.add_child(target_inst)
		target_inst.initiate(phase)
		target_inst.name = str("target", i + 1)
		target_inst.hit.connect(hit.bind(target_inst))
		target_inst.die.connect(die)

func hit(target: Area2D) -> void:
	score += 1

func die():
	await get_tree().process_frame
	if carl_jrs_parent.get_child_count() < 1:
		phase += 1
		if phase > 3:
			win()
		else:
			spawn_targets(phase * difficulty)

func _on_timer_timeout() -> void:
	if won:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://minigames/minigames.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed == true:
			animation.play("gunshot")
			crosshair.play("shot")
			crosshair.frame = 0
