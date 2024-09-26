extends Area2D

var posx = 0
var posy = 0
var boyposx = 100
var boyposy = 100
var girlposx = 100
var girlposy = 100
var tf = false
var timer = 0
var boy = false
var girl = false

func _process(_delta):
	if boy:
		timer += 1
	if timer > 1:
		boy = false
		timer = 0
	if girl:
		timer += 1
	if timer > 1:
		girl = false
		timer = 0
