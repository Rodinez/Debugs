extends RigidBody2D

var bullet_speed = 1000
var bullet = preload("res://scenes/BulletEnemy.tscn")
var can_fire = true

func _ready():
	pass

func _process(delta):
	look_at(Global.player_position)
	if can_fire:
		fire()

func fire():
	can_fire = false
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = $Marker2D.position
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_central_impulse(Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_instance)
	$Timer.start()

func _on_timer_timeout():
	can_fire = true

func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		queue_free()
