extends Node2D

@onready var path_follow = PathFollow2D.new()

var speed = 100.0
var distance = 0.0
var health = 100

func _ready():
	path_follow.set_cubic_interpolation(true)
	add_child(path_follow)

func move_along_path(delta):
	distance += delta * speed
	if distance >= 1.0:
		queue_free()
	else:
		path_follow.progress_ratio = distance
		global_position = path_follow.global_position

func take_damage(damage):
	health -= damage
	if health <= 0:
		queue_free()
