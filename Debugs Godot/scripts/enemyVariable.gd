extends RigidBody2D

func _ready():
	pass 
	
func _process(delta):
	position += (Global.player_position - position)/50
	look_at(Global.player_position)
	move_and_collide(Vector2())


func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		queue_free()
