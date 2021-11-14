extends Node2D

var speed = 30
var direction = Vector2.ZERO

var stop = false

func _physics_process(delta):
	if direction != Vector2.ZERO and not stop:
		var velocity = direction * speed
		
		global_position += velocity


func set_direction(direction: Vector2):
	self.direction = direction


func _on_Area2D_body_entered(body):
	if body.is_in_group("wall"):
		$wall_hit.play()
	elif body.is_in_group("rock"):
		$rock_hit.play()
	elif body.is_in_group("glass"):
		$glass_hit.play()


func _on_Timer_timeout():
	queue_free()
