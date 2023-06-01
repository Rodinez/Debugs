extends RigidBody2D

func _ready():
	pass 
	
func _process(delta):
	var Player = get_parent().get_node("player")
	position += (Player.position - position)/50
	look_at(Player.position)
	move_and_collide(Vector2())


func _on_area_2d_body_entered(body):
	if "bullet" in body.name:
		queue_free()
