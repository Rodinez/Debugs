extends RigidBody2D
var life = 10

func _ready():
	if Global.index >= 9:
		life = 30
	elif Global.index >= 6:
		life = 20
	elif Global.index >= 3:
		life = 15
	
func _process(_delta):
	position += (Global.player_position - position)/50
	look_at(Global.player_position)
	move_and_collide(Vector2())


func _on_area_2d_body_entered(body):
	if "player" in body.name and Global.upgrades[3] == 1:
		Global.alive -= 1
		queue_free()
	if "bulletPlayer" in body.name:
		life -= Global.dmg
	if life <= 0:
		Global.alive -= 1
		queue_free()
