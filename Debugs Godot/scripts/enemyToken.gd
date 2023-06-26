extends RigidBody2D
var life = 10

var bullet_speed = 1000
var bullet = preload("res://scenes/BulletEnemy.tscn")
var can_fire = true

func _ready():
	if Global.index >= 9:
		life = 24
	elif Global.index >= 6:
		life = 18
	elif Global.index >= 3:
		life = 15

func _process(delta):
	if can_fire:
		fire()

func fire():
	can_fire = false
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = $Marker2D.global_position
	get_parent().add_child(bullet_instance)
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_central_impulse((Global.player_position - global_position).normalized() * bullet_speed)
	$Timer.start()

func _on_timer_timeout():
	can_fire = true

func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		life -= Global.dmg
	if life <= 0:
		Global.alive -= 1
		queue_free()
