extends RigidBody2D

@export var speed = 400 
var screen_size
var bullet_speed = 1500
var bullet = preload("res://scenes/Bullet.tscn")
var can_fire = true

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
		fire()
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	look_at(get_global_mouse_position())
	
	
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
	if "enemy" in body.name:
		get_tree().change_scene_to_file("res://scenes/kill.tscn")
