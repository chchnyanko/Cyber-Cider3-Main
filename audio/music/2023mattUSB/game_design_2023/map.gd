extends Spatial

var left = false
var right = false
var enemytimer = 0
var enemyyn = false

func _on_right_area_entered(area):
	if area.name == "object":
		right = true

func _on_right_area_exited(area):
	if area.name == "object":
		right = false

func _on_left_area_entered(area):
	if area.name == "object":
		left = true

func _on_left_area_exited(area):
	if area.name == "object":
		left = false

func _physics_process(delta):
	print(enemytimer)
	if enemyyn:
		enemytimer += delta
	if Input.is_action_pressed("left") and not left:
		rotation_degrees.y -= 1
	if Input.is_action_pressed("right") and not right:
		rotation_degrees.y += 1
	if enemytimer > 1:
		print("joe")
		get_tree().change_scene("res://enemy_combat_test.tscn")

func _on_enemy_body_entered(body):
	if body.name == "player":
		enemyyn = true
		enemytimer = 0
		enemy.type = 10
		$enemy/enemy/Sprite3D.translation.x = 0
		$enemy/enemy/Sprite3D.translation.y = 3.846
		$enemy/enemy/Sprite3D.translation.z = 0.205
