extends Node2D

var target: Vector2 = Vector2.ZERO
export(int) var speed = 30
export(bool) var instant_spawn = false

var rng = RandomNumberGenerator.new()
var spawn_time = 0
var delta_timer = Delta_Timer.new()
var spawn = false

signal spawned

export(NodePath) var enemy
var _enemy

func _ready():
	rng.randomize()
	spawn_time = rng.randf_range(0.0, 10.0)
	_enemy = get_node(enemy)
	_enemy.visible = false
	var targets = get_tree().get_nodes_in_group("target")
	var non_infected_targets = filter_out_infected(targets)
	
	if non_infected_targets.size() > 0:
		non_infected_targets.shuffle()
		target = non_infected_targets[0].global_position
	
	if instant_spawn:
		spawn = true
		_enemy.visible = true
		emit_signal("spawned")


func filter_out_infected(targets: Array) -> Array:
	var filtered_list = []
	for target in targets:
		if not target.is_infected():
			filtered_list.append(target)
	
	return filtered_list


func _physics_process(delta):
	if target != Vector2.ZERO and delta_timer.timer(delta, spawn_time, true):
		spawn = true
		_enemy.visible = true
		emit_signal("spawned")
	
	if spawn:
		var velocity = _enemy.position.direction_to(target) * speed * delta
		
		_enemy.position += velocity
