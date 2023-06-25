extends CharacterBody2D

func _process(delta):
	pass



func _on_area_2d_body_entered(body):
	if Global.alive == 0:
		Global.index += 1
