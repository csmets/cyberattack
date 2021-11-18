extends Node2D

var speed = 30

var stop = false

func _physics_process(delta):
	if not stop:
		var velocity = Vector2(speed, 0).rotated(rotation)
		
		global_position += velocity


func _on_Area2D_body_entered(body):
	if body.is_in_group("wall"):
		$wall_hit.play()
	elif body.is_in_group("rock"):
		$rock_hit.play()
	elif body.is_in_group("glass"):
		$glass_hit.play()


func _on_Timer_timeout():
	queue_free()
