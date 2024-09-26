extends Node2D

var a = 0
var timer = 0

func _ready():
	get_tree().paused = false
	sound.play_dominic_music()

func _process(delta):
	print(a)
	if a == 0 and $title.position.y > -2200:
		$title.position.y -= 8
		$"created by".position.y -= 8
	elif a == 0:
		a = 1
	if a == 1:
		if $boy.position.x < 700:
			$boy.position.x += 5
			$girl.position.x -= 5
		else:
			$boy.animation = "stand"
			$girl.animation = "stand"
			$wall.playing = true
		if $wall.frame == 11:
			a = 2
	if a == 2:
		if  $boy.position.y > -500:
			$boy.position.y -= 10
			$girl.position.y -= 10
			$wall.position.y -= 10
		else:
			a = 3
	if a == 3:
		if $TileMap.position.y > 0:
			$art.position.y -= 10
			$level.position.y -= 10
			$TileMap.position.y -= 10
			$Door.position.y -= 10
			$Door2.position.y -= 10
		else:
			a = 4
			$TileMap.position.y = 0
	if a == 4:
		if $boy2.position.x < 2000:
			$boy2.position.x += 5
			$girl2.position.x -= 5
		else:
			a = 5
			$boy2.hide()
			$girl2.hide()
			$Door.frame = 1
			$Door2.frame = 0
	if a == 5:
		if $TileMap.position.y > -1500:
			$TileMap.position.y -= 10
			$Door.position.y -= 10
			$Door2.position.y -= 10
			$level.position.y -= 10
			$programming.position.y -= 10
		else:
			a = 6
	if a == 6:
		if $girl3.position.x >1000:
			$girl3.position.x -= 10
			$girl3.position.y -= 10
		elif $girl3.position.x > -200:
			$girl3.frame = 1
			$girl3.position.x -= 10
			$girl3.position.y += 8
		else:
			a = 7
	if a == 7:
		if $sound.position.y > -1500:
			$programming.position.y -= 10
			$sound.position.y -= 10
		else:
			a = 8
			$boy.animation = "default"
			$girl.animation = "default"
			$boy.position.x = -200
			$boy.position.y = 800
			$girl.position.x = 2480
			$girl.position.y = 800
	if a == 8:
		if $boy.position.x < 1000:
			$boy.position.x += 5
			$girl.position.x -= 5
		else:
			a = 9
	if a == 9:
		if $thanks.position.y > -4200:
			$boy.position.y -= 10
			$girl.position.y -= 10
			$thanks.position.y -= 10
		else:
			a = 10
	if a == 10:
		timer += delta
	if timer > 10:
		get_tree().change_scene_to_file("res://title.tscn")
	
