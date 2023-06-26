extends RigidBody2D

@export var speed = 500 
var screen_size
var bullet = preload("res://scenes/Bullet.tscn")
var can_fire = true

func _ready():
	$Timer.set_wait_time(Global.firetime)
	screen_size = get_viewport_rect().size
	
func _process(delta):
	Global.player_position = self.position
	var velocity = Vector2.ZERO 
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1   
	if Input.is_action_pressed("move_down"):
		velocity.y += 1  
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("fire") and can_fire: 
		fire(Global.gun)
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	look_at(get_global_mouse_position())
	
	
func fire(gun):
	if gun == "p" or gun == "m" or gun == "n":
		can_fire = false
		var bullet_instance = bullet.instantiate()
		get_parent().add_child(bullet_instance)
		bullet_instance.position = $Marker2D.global_position
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_central_impulse((get_global_mouse_position() - global_position).normalized() * Global.bullet_speed)
	elif gun == "s":
		can_fire = false
		var bullet_instance = bullet.instantiate()
		var bullet_instance1 = bullet.instantiate()
		var bullet_instance2 = bullet.instantiate()
		var bullet_instance3 = bullet.instantiate()
		get_parent().add_child(bullet_instance)
		get_parent().add_child(bullet_instance1)
		get_parent().add_child(bullet_instance2)
		get_parent().add_child(bullet_instance3)
		bullet_instance.position = $Marker2D.global_position
		bullet_instance1.position = $Marker2D.global_position
		bullet_instance2.position = $Marker2D.global_position
		bullet_instance3.position = $Marker2D.global_position
		bullet_instance.apply_central_impulse((get_global_mouse_position() - global_position).normalized() * Global.bullet_speed - Vector2(0,30))
		bullet_instance1.apply_central_impulse((get_global_mouse_position() - global_position).normalized() * Global.bullet_speed + Vector2(100,500))
		bullet_instance2.apply_central_impulse((get_global_mouse_position() - global_position).normalized() * Global.bullet_speed - Vector2(200,200))
		bullet_instance3.apply_central_impulse((get_global_mouse_position() - global_position).normalized() * Global.bullet_speed)
	$Timer.start()

func _on_timer_timeout():
	can_fire = true
	
func _on_area_2d_body_entered(body): 
	if "enemy" in body.name:
		if Global.upgrades[3] == 1:
			Global.upgrades[3] = 0
		else: 
			get_tree().change_scene_to_file("res://scenes/kill.tscn")
	if "shotgun" in body.name:
		Global.gun = "s"
		Global.firetime = 0.65
		$Timer.set_wait_time(Global.firetime)
		Global.dmg = 3
		Global.bullet_speed = 2000
	elif "sniper" in body.name:
		Global.gun = "n"
		Global.dmg = 10
		Global.bullet_speed = 3000
		Global.firetime = 1
		$Timer.set_wait_time(Global.firetime)
	elif "minigun" in body.name:
		Global.gun = "m"
		Global.firetime = 0.2
		$Timer.set_wait_time(Global.firetime)
	if "BB" in body.name:
		speed = 600
		Global.upgrades[0] = 1
	if "BT" in body.name or Global.upgrades[1] == 1:
		Global.upgrades[1] = 1
		match Global.gun:
			"p": Global.dmg = 3
			"s": Global.dmg = 4
			"m": Global.dmg = 3
			"n": Global.dmg = 15
	if "qsort" in body.name or Global.upgrades[2] == 1:
		Global.upgrades[2] = 1
		match Global.gun:
			"p": Global.firetime = 0.25
			"s": Global.firetime = 0.5
			"m": Global.firetime = 0.15
			"n": Global.firetime = 0.75
		$Timer.set_wait_time(Global.firetime)
	if "debbuger" in body.name:
		Global.upgrades[3] = 1

