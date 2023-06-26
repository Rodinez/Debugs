extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_restart_pressed():
	Global.index = 0
	Global.dmg = 2
	Global.gun = "p"
	Global.firetime = 0.33
	Global.bullet_speed = 1500
	Global.alive = 0
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
