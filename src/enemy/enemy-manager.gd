extends Node2D

onready var enemy = preload("res://src/enemy/enemy.tscn")
onready var enemy_breakable = preload("res://src/enemy/breakable-enemy.tscn")
onready var enemy_spawner = preload("res://src/enemy/enemy-spawner.tscn")

var _wave_multiplier = 3
var _wave_time = 15 #seconds
var _wave_length = 0
var _enemies = 1

var spawn_points: Array = []

var wave = 0
var trigger_next_wave = false
var start = false

var rng = RandomNumberGenerator.new()

func setup(wave_time, wave_multiplier, wave_length, enemies):
	_wave_time = wave_time
	_wave_multiplier = wave_multiplier
	_wave_length = wave_length
	_enemies = enemies


func _ready():
	rng.randomize()
	spawn_points = get_tree().get_nodes_in_group("spawn_point")
	Game_data.connect("spawn_enemies", self, "spawn_enemies")


func _physics_process(delta):
	var number_of_enemies = get_tree().get_nodes_in_group("enemy").size()
	
	if start and number_of_enemies <= 0 and not trigger_next_wave:
		if wave == _wave_length:
			Game_data.level_complete()
		else:
			trigger_next_wave = true
			next_wave()


func next_wave():
	Game_data.start_countdown(_wave_time)
	Game_data.spawn_powerups(wave + 1)


func spawn_enemies():
	start = true
	wave += 1
	Game_data.wave_count = wave
	var number_to_spawn = wave * _wave_multiplier
	for number in range(number_to_spawn):
		spawn_enemy(spawn_position())
	trigger_next_wave = false


func spawn_position() -> Vector2:
	var max_spawn_points = spawn_points.size() - 1
	var index = rng.randi_range(0, max_spawn_points)
	return spawn_points[index].position


func spawn_enemy(position: Vector2):
	var enemy_type = rng.randi_range(1, _enemies)
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
