# Main game script for a simple 2D tower defense game in Godot 4.3
# Inspired by Bloons TD Battles (single-player, no monkeys)

extends Node2D

@onready var path = $Path2D/PathFollow2D
@onready var enemy_scene = preload("res://Enemy.tscn")
@onready var tower_scene = preload("res://Tower.tscn")

var enemies = []
var towers = []
var spawn_timer = 0.0
var spawn_interval = 2.0

func _ready():
	set_process(true)

func _process(delta):
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()

	for enemy in enemies:
		if enemy: enemy.move_along_path(delta)

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemy.global_position = path.global_position
	enemies.append(enemy)

func _on_TowerPlacement_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		place_tower(event.position)

func place_tower(position):
	var tower = tower_scene.instantiate()
	add_child(tower)
	tower.global_position = position
	towers.append(tower)
