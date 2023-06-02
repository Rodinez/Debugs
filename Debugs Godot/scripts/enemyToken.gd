extends RigidBody2D

var bullet_speed = 1000
var bullet = preload("res://scenes/BulletEnemy.tscn")
var can_fire = true

func _ready():
	pass

func _process(delta):
	var Player = get_parent().get_node("player")
	look_at(Player.position)
	if can_fire:
		fire()

func fire():
	can_fire = false
	var bullet_intance = bullet.instantiate()
	bullet_intance.position = get_global_position()
	bullet_intance.rotation_degrees = rotation_degrees
	bullet_intance.apply_central_impulse(Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_intance)
	$Timer.start()

func _on_timer_timeout():
	can_fire = true

func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		queue_free()
