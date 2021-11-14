extends Area2D

var target: Vector2 = Vector2.ZERO
var speed = 2

func _ready():
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
	if target != Vector2.ZERO:
		var velocity = position.direction_to(target) * speed
		
		position += velocity


func _on_area_entered(area: Area2D):
	if area.is_in_group("bullet"):
		self.queue_free()
