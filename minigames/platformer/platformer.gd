extends Node2D

@export_range(1, 100, 1) var length: int
@export_range(1, 3) var level: int

@onready var player: CharacterBody2D = $player
@onready var label: Label = $Label
@onready var door: Area2D = $door
@onready var timer: Timer = $Timer
@onready var camera_2d: Camera2D = $player/Camera2D
@onready var tilemap: TileMapLayer = $tilemap

func _ready() -> void:
	if level == 0:
		level = 1
	for i in length:
		var random = randi_range(1, level * 5)
		var template: PackedScene = load(str("res://minigames/platformer/tiletemplate", random, ".tscn"))
		var template_instance = template.instantiate()
		template_instance.position.x = i * 1920
		add_child(template_instance)
		for j in 30:
			tilemap.set_cell(Vector2i((i * 30 + j), -1), 1, Vector2i(0, 0), 0)
	for i in 17:
		tilemap.set_cell(Vector2i((length * 30), i), 1, Vector2i(0, 0), 0)
	door.position.x = length * 1920 - 100
	camera_2d.limit_right = 1920 * length

func _process(delta: float) -> void:
	#print(player.position)
	if player.position.y > 1080:
		lose()

func win():
	label.text = "You win"
	timer.start(0.5)

func lose():
	if timer.time_left == 0:
		timer.start(0.5)

func _on_door_body_entered(body: Node2D) -> void:
	if body.name == "player":
		win()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://minigames/minigames.tscn")
