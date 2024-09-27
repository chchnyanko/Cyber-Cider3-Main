extends Node2D

@onready var timer: Timer = $Timer
@onready var boulder = preload("res://minigames/boulder_escape/boulder.tscn")

var stars: int = 0
var won: bool

func _ready() -> void:
	for i: Area2D in get_tree().get_nodes_in_group("star"):
		i.body_entered.connect(_on_star_body_entered.bind(i))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if stars == 6:
			win()

func touched_boulder(body: Node2D):
	if body.name == "player":
		lose()

func win():
	$Label.text = "You win"
	won = true
	timer.start(0.5)

func lose():
	timer.start(0.5)

func _on_timer_timeout() -> void:
	if unlocks.cube_2_1:
		get_tree().change_scene_to_file("res://minigames/minigames.tscn")
	else:
		if won:
			unlocks.cubes += 1
			unlocks.cube_2_1 = true
		get_tree().change_scene_to_file("res://3D/city.tscn")

func _on_star_body_entered(body: Node2D, star: Area2D) -> void:
	if body.name == "player":
		stars += 1
		star.get_parent().queue_free()
		var boulder_inst: RigidBody2D = boulder.instantiate()
		add_child(boulder_inst)
		boulder_inst.set_deferred("position", Vector2(randi_range(300, 1600), -200))
		boulder_inst.body_entered.connect(touched_boulder)
