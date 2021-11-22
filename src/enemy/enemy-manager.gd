extends Node2D

onready var enemy = preload("res://src/enemy/enemy.tscn")
onready var enemy_breakable = preload("res://src/enemy/breakable-enemy.tscn")
onready var enemy_spawner = preload("res://src/enemy/enemy-spawner.tscn")

var wave_multiplier = 3
var wave_time = 15 #seconds

var spawn_points: Array = []

var wave = 0
var trigger_next_wave = false

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()
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
	var max_spawn_points = spawn_points.size() - 1
	var index = rng.randi_range(0, max_spawn_points)
	return spawn_points[index].position


func spawn_enemy(position: Vector2):
	var enemy_type = rng.randi_range(1, 3)
	var instance
	match(enemy_type):
		1:
			instance = enemy.instance()
		2:
			instance = enemy_breakable.instance()
		3:
			instance = enemy_spawner.instance()
	get_tree().root.add_child(instance)
	instance.position = position
