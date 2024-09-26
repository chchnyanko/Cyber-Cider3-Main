extends Label

var it = false
var rand = 0
var spin = 0.01
var play = true
var girl_time = 0
var boy_time = 0

func _process(delta):
	if boy_time >= 180:
		play = false
		spin = 0.1
		$Camera/AnimatedSprite3D.animation = "win"
	elif girl_time >= 180:
		play = false
		spin = 0.1
		$Camera/AnimatedSprite3D.animation = "win"
	else:
		$Camera/AnimatedSprite3D.translation.z += 0.1 * delta
	$Camera/AnimatedSprite3D.rotate_y(spin)
	if it:
		$boy.speed = 500
		$girl.speed = 400
		$boy.modulate.g = 0
		$girl.modulate.g = 1
		text = "boy is it"
		$Camera/AnimatedSprite3D.frame = 0
		boy_time += 0.1
		print(boy_time)
	if not it:
		$girl.speed = 500
		$boy.speed = 400
		$boy.modulate.g = 1
		$girl.modulate.g = 0
		text = "girl is it"
		$Camera/AnimatedSprite3D.frame = 1
		girl_time += 0.1
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene("res://level select.tscn")

func _ready():
	settings.boydoor = false
	settings.girldoor = false
	reset()

func reset():
	sound.play_tag_music()
	$Camera/AnimatedSprite3D.animation = "play"
	play = true
	spin = 0.01
	randomize()
	rand = randi()%2
	if rand == 0:
		it = true
	elif rand == 1:
		it = false

func _on_Area2D_body_entered(body):
	if body.name == "girl" and play:
		it = !it
