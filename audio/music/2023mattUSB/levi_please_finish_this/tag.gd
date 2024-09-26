extends Label

var it = false
var rand = 0
var play = true
var girl_time = 0
var boy_time = 0
var boy = load("res://game development tileset/tag-3.png.png")
var girl = load("res://game development tileset/tag-4.png.png")
var itpro = load("res://game development tileset/tag-2.png.png")
var notitpro = load("res://game development tileset/tag-1.png.png")
var girlwin = load("res://game development tileset/New Piskel-2.png (1).png")
var boywin = load("res://game development tileset/New Piskel-1.png (1).png")
var boyit = load("res://game development tileset/New Piskel-1.png.png")
var girlit = load("res://game development tileset/New Piskel-2.png.png")

func _process(delta):
	if boy_time >= 30 or girl_time >= 30:
		$Button.show()
		play = false
		$Camera3D/AnimatedSprite3D.rotate_y(0.1)
		$boyprogress.value = 30
		$girlprogress.value = 30
		if it:
			$boyprogress.texture_progress = girl
			$Camera3D/AnimatedSprite3D.texture = girlwin
		if not it:
			$girlprogress.texture_progress = boy
			$Camera3D/AnimatedSprite3D.texture = boywin
	elif it:
		$boyprogress.value = boy_time
		$boy.speed = 500
		$girl.speed = 400
		$boy.modulate.g = 0
		$girl.modulate.g = 1
		text = "boy is it"
		$Camera3D/AnimatedSprite3D.texture = boyit
		boy_time += delta
		$boyprogress.texture_under = itpro
		$girlprogress.texture_under = notitpro
		$Camera3D/AnimatedSprite3D.rotate_y(boy_time/300)
	elif not it:
		$girlprogress.value = girl_time
		$girl.speed = 500
		$boy.speed = 400
		$boy.modulate.g = 1
		$girl.modulate.g = 0
		text = "girl is it"
		$Camera3D/AnimatedSprite3D.texture = girlit
		girl_time += delta
		$girlprogress.texture_under = itpro
		$boyprogress.texture_under = notitpro
		$Camera3D/AnimatedSprite3D.rotate_y(girl_time/300)
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://level select.tscn")

func _ready():
	settings.boydoor = false
	settings.girldoor = false
	reset()

func reset():
	sound.play_tag_music()
	boy_time = 0
	girl_time = 0
	play = true
	randomize()
	rand = randi()%2
	if rand == 0:
		it = true
	elif rand == 1:
		it = false

func _on_Area2D_body_entered(body):
	if body.name == "girl" and play:
		it = !it

func _on_Button_pressed():
	get_tree().change_scene_to_file("res://stupid.tscn")
