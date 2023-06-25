extends RigidBody2D

@export var speed = 400 
var screen_size
var bullet_speed = 1500
var bullet = preload("res://scenes/Bullet.tscn")
var can_fire = true
var gun = "p"

func _ready():
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
		fire(gun)
		
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
	if gun == "p":
		can_fire = false
		var bullet_instance = bullet.instantiate()
		get_parent().add_child(bullet_instance)
		bullet_instance.position = $Marker2D.global_position
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_central_impulse((get_global_mouse_position() - global_position).normalized() * bullet_speed)
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
		bullet_instance.apply_central_impulse((get_global_mouse_position() - global_position).normalized() * bullet_speed - Vector2(0,100))
		bullet_instance1.apply_central_impulse((get_global_mouse_position() - global_position).normalized() * bullet_speed + Vector2(100,100))
		bullet_instance2.apply_central_impulse((get_global_mouse_position() - global_position).normalized() * bullet_speed - Vector2(200,50))
		bullet_instance3.apply_central_impulse((get_global_mouse_position() - global_position).normalized() * bullet_speed)
	$Timer.start()

func _on_timer_timeout():
	can_fire = true
	
func _on_area_2d_body_entered(body): 
	if "enemy" in body.name:
		get_tree().change_scene_to_file("res://scenes/kill.tscn")
	if "shot" in body.name:
		gun = "s"
		$Timer.set_wait_time(0.65)
		Global.dmg = 3
