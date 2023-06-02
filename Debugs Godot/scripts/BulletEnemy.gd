extends RigidBody2D

func _ready():
	pass 

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if "player" in body.name:
		queue_free()
