extends CharacterBody2D

var bullet_speed = 1000
var bullet = preload("res://scenes/BulletEnemy.tscn")
var can_fire = true

func _ready():
	pass

func _process(delta):
	$Marker2D.position = get_parent().position
	if can_fire:
		fire()

func fire():
	can_fire = false
	var bullet_isntance = bullet.instantiate()
	get_tree().get_root().call_deferred("add_child",bullet_isntance)
	bullet_isntance.position = $Marker2D.position
	$Timer.start()

func _on_timer_timeout():
	can_fire = true

func _on_area_2d_body_entered(body):
	if "bulletPlayer" in body.name:
		queue_free()
