extends Node2D

var goal = true

func _ready():
	$HSlider.value = set.goal
	goal = set.goalyn

func _process(delta):
	$goalnumber.text = str($HSlider.value)
	set.goal = $HSlider.value
	if goal == true:
		$Button.text = ("on")
	else:
		$Button.text = ("off")


func _on_Button_pressed():
	goal = !goal
	set.goalyn = !set.goalyn
