extends Area2D

onready var explosion = preload("res://src/explosions/explosion.tscn")

var target: Vector2 = Vector2.ZERO
var speed = 2

var rng = RandomNumberGenerator.new()
var spawn_time = 0
var delta_timer = Delta_Timer.new()
var spawn = false

func _ready():
	rng.randomize()
	spawn_time = rng.randf_range(0.0, 10.0)
	self.visible = false
	var targets = get_tree().get_nodes_in_group("target")
	var non_infected_targets = filter_out_infected(targets)
	
	if non_infected_targets.size() > 0:
		non_infected_targets.shuffle()
		target = non_infected_targets[0].global_position


func filter_out_infected(targets: Array) -> Array:
	var filtered_list = []
	for target in targets:
		if not target.is_infected():
			filtered_list.append(target)
	
	return filtered_list


func _physics_process(delta):
	if target != Vector2.ZERO and delta_timer.timer(delta, spawn_time, true):
		spawn = true
		self.visible = true
	
	if spawn:
		var velocity = position.direction_to(target) * speed
		
		position += velocity


func _on_area_entered(area: Area2D):
	if area.is_in_group("bullet"):
		# add an explosion to the scene
		var explosion_instance = explosion.instance()
		get_tree().root.add_child(explosion_instance)
		explosion_instance.position = self.global_position
		Game_data.camera.shake(300, 1, 150)
		self.queue_free()
