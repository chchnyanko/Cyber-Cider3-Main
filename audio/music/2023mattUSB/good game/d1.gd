extends Area2D

var d1

func _on_d1_area_entered(area):
	print (area)
	if area:
		if c1.colour == 1:
			d1 = 1
		elif c1.colour == 2:
			d1 = 2
		elif c1.colour == 3:
			d1 = 3
		elif c1.colour == 4:
			d1 = 4
		else:
			d1 = 0
	if d1 == 1 or d1 == 2 or d1 == 3 or d1 == 4 or d1 == 0:
		print (d1)
