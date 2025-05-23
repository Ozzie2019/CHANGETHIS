extends Node2D

@export var range: float = 100.0
@export var fire_rate: float = 1.0
@export var bullet_scene: PackedScene

var target = null
var time_since_last_shot = 0.0

func _process(delta):
	time_since_last_shot += delta
	if target and is_instance_valid(target):
		look_at(target.global_position)
		if time_since_last_shot >= fire_rate:
			shoot()
			time_since_last_shot = 0.0
	else:
		find_target()

func find_target():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if global_position.distance_to(enemy.global_position) <= range:
			target = enemy
			break

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.target = target
	get_parent().add_child(bullet)
