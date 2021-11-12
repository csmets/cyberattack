extends Node2D

var number_of_waves = 3
var wave_multiplier = 3

var spawn_points: Array = []

var wave = 1

onready var enemy = preload("res://src/enemy/enemy.tscn")

func _ready():
	spawn_points = get_tree().get_nodes_in_group("spawn_point")


func _physics_process(delta):
	var number_of_enemies = get_tree().get_nodes_in_group("enemy").size()
	
	if number_of_enemies <= 0:
		spawn_enemies()


func spawn_enemies():
	if wave <= number_of_waves:
		wave += 1
		var number_to_spawn = wave * wave_multiplier
		for number in range(number_to_spawn):
			spawn_enemy(spawn_position())


func spawn_position() -> Vector2:
	var max_spawn_points = spawn_points.size()
	
	spawn_points.shuffle()
	
	return spawn_points[0].position


func spawn_enemy(position: Vector2):
	var instance = enemy.instance()
	get_tree().root.add_child(instance)
	instance.position = position
