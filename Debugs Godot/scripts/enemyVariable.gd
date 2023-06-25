extends RigidBody2D
var life = 15

func _ready():
	pass 
	
func _process(delta):
	position += (Global.player_position - position)/50
	look_at(Global.player_position)
	move_and_collide(Vector2())


func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		life -= Global.dmg
	if life <= 0:
		Global.alive -= 1
		queue_free()
