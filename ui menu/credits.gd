extends Node2D

@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation.play("credits")

func exit():
	get_tree().change_scene_to_file("res://ui menu/title.tscn")
