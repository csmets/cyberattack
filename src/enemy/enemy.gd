extends Sprite

var target: Vector2 = Vector2.ZERO
var speed = 2

func _ready():
	var targets = get_tree().get_nodes_in_group("target")
	targets.shuffle()
	target = targets[0].global_position


func _physics_process(delta):
	if target != Vector2.ZERO:
		var velocity = position.direction_to(target) * speed
		
		position += velocity


func _on_area_entered(area: Area2D):
	if area.is_in_group("bullet"):
		self.queue_free()
