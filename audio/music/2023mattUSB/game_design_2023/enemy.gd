extends Spatial

#func _ready():
#	$AnimatedSprite3D.play(enemy.type)

func _physics_process(delta):
	if $AnimatedSprite3D.translation.x < 1:
		$AnimatedSprite3D.translation.x += 0.012
	if $AnimatedSprite3D.translation.y > 0.75:
		$AnimatedSprite3D.translation.y -= 0.01
	if $AnimatedSprite3D.translation.z > -1:
		$AnimatedSprite3D.translation.z -= 0.03
