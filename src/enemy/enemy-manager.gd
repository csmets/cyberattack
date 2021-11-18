extends Node2D

onready var enemy = preload("res://src/enemy/enemy.tscn")

var wave_multiplier = 3
var wave_time = 15 #seconds

var spawn_points: Array = []

var wave = 0
var trigger_next_wave = false


func _ready():
	spawn_points = get_tree().get_nodes_in_group("spawn_point")
	Game_data.connect("spawn_enemies", self, "spawn_enemies")


func _physics_process(delta):
	var number_of_enemies = get_tree().get_nodes_in_group("enemy").size()
	
	if number_of_enemies <= 0 and not trigger_next_wave:
		trigger_next_wave = true
		next_wave()


func next_wave():
	Game_data.start_countdown(wave_time)
	Game_data.spawn_powerups(wave + 1)


func spawn_enemies():
	wave += 1
	Game_data.wave_count = wave
	var number_to_spawn = wave * wave_multiplier
	for number in range(number_to_spawn):
		spawn_enemy(spawn_position())
	trigger_next_wave = false


func spawn_position() -> Vector2:
	var max_spawn_points = spawn_points.size()
	
	spawn_points.shuffle()
	
	return spawn_points[0].position


func spawn_enemy(position: Vector2):
	var instance = enemy.instance()
	get_tree().root.add_child(instance)
	instance.position = position
