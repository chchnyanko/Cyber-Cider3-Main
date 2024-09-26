extends Popup

var frame = 0

func _ready():
	show()

func _process(delta):
	if Input.is_action_just_pressed("right"):
		plus()
	if Input.is_action_just_pressed("left"):
		minus()
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene("res://scenes/menu/main_menu.tscn")
	if frame == 0:
		$AnimatedSprite.play("cursor")
		$Label.text = ("Use Arrow Keys Or WASD To Move The Cursor")
		$Label2.text = ("1/4")
	if frame == 1:
		$AnimatedSprite.play("block")
		$Label.text = ("Hold Space Bar And Use Blocks To Move Blocks In That Way")
		$Label2.text = ("2/4")
	if frame == 2:
		$AnimatedSprite.play("up")
		$Label.text = ("You Can Also Move Blocks Vertically")
		$Label2.text = ("3/4")
	if frame == 3:
		$AnimatedSprite.play("clear")
		$Label.text = ("By Matching A Row Or Column With The Same Colour Those Blocks Will Change Colour And You Will Get Points")
		$Label2.text = ("4/4")

func plus():
	$AnimatedSprite.frame = 0
	if frame == 3:
		frame = 0
	else:
		frame += 1

func minus():
	$AnimatedSprite.frame = 0
	if frame == 0:
		frame = 3
	else:
		frame -= 1

func _on_Button_pressed():
	plus()

func _on_Button2_pressed():
	minus()


func _on_Button3_pressed():
	get_tree().change_scene("res://scenes/options/options.tscn")
