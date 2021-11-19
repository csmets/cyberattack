extends Node2D

onready var rapid_fire = preload("res://src/powerups/rapid-fire.tscn")
onready var multi_fire = preload("res://src/powerups/multi-fire.tscn")

var multipler = 1
var rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	rng.randomize()
	Game_data.connect("spawn_powerups", self, "place_powerups")


func place_powerups(wave: int):
	
	var possible_amount = wave * multipler
	var amount = rng.randi_range(1, possible_amount)
	var spawn_points = get_tree().get_nodes_in_group("powerup_spawn_point")
	
	for num in range(amount):
		var index = rng.randi_range(0, spawn_points.size() - 1)
		var spawn_position = spawn_points[index].position
		var powerup_num = rng.randi_range(1, 2)
		
		if (powerup_num == 1):
			var instance = rapid_fire.instance()
			get_tree().root.add_child(instance)
			instance.global_position = spawn_position
		
		if powerup_num == 2:
			var instance = multi_fire.instance()
			get_tree().root.add_child(instance)
			instance.global_position = spawn_position
