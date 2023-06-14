extends Area2D

var speed = 400
var direction = Vector2(0,0)

func _ready():
	pass 

func _process(delta):
	look_at(Global.player_position)
	position = speed * delta * direction

func _on_area_2d_body_entered(body):
	if "player" in body.name:
		queue_free()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
