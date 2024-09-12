extends Node2D

@export_range(1, 10, 1) var number_of_items: int
@export_range(0, 10, 1) var number_of_fake_items: int

@onready var potion: PackedScene = preload("res://minigames/potion_making/potion.tscn")
@onready var instruction: RichTextLabel = $RichTextLabel
@onready var timer: Timer = $Timer

const ingredients: Dictionary = {
	"red": ["color", "#ff0000"],
	"green": ["color", "#00ff00"],
	"blue": ["color", "#0000ff"],
	"white": ["color", "#ffffff"],
	"black": ["color", "#000000"],
	"shaky": ["shake", "rate=100"],
	"rainbow": ["rainbow", "freq=1 sat=1 val=1"],
	"tornado": ["tornado", "radius=0.1"],
	"wave": ["wave", "amp=1"],
	"pulse": ["pulse", "freq=1.0 color=#ffffff40 ease=-2.0"]
}

var needed_ingredients: Array

func _ready() -> void:
	set_text()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		remove_item()

func remove_item(item_name: String = ""):
	if item_name == "":
		needed_ingredients.remove_at(0)
	else:
		if item_name in needed_ingredients:
			needed_ingredients.erase(item_name)
		else:
			return
	set_text(true)
	if needed_ingredients.size() == 0:
		win()
		return

func set_text(resetting: bool = false):
	instruction.text = "To make the potion you must bring these ingredients and place them in my cauldron \n"
	if resetting:
		for i in needed_ingredients.size():
			instruction.text += get_text(needed_ingredients[i])
			if i < needed_ingredients.size() - 1:
				instruction.text += ", \n"
	else:
		for i in number_of_items:
			var ingredient = get_random_ingredient()
			instruction.text += get_text(ingredient)
			needed_ingredients.append(ingredient)
			if i < number_of_items - 1:
				instruction.text += ", \n"
			create_item(ingredient)
		for i in number_of_fake_items:
			var ingredient = get_random_ingredient()
			create_item(ingredient)

func create_item(item_name: String):
	var potion_instance = potion.instantiate()
	add_child(potion_instance)
	potion_instance.set_item_name(item_name)
	potion_instance.change_text(get_text(item_name))
	potion_instance.change_position()

func get_random_ingredient() -> String:
	return ingredients.keys()[randi_range(0, ingredients.size()-1)]

func get_text(text: String = "random") -> String:
	if text == "random":
		text = get_random_ingredient()
	text = str("[", ingredients.get(text)[0], "=", ingredients.get(text)[1], "]", text, "[/", ingredients.get(text)[0], "]")
	return text

func _on_cauldron_area_entered(area: Area2D) -> void:
	if area is potion:
		remove_item(area.get_item())
		area.queue_free()

func win():
	timer.start(0.5)

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://minigames/minigames.tscn")
