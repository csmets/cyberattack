extends AnimatedSprite

onready var target = $Target

func _on_heal_zone_body_entered(body):
	if body.is_in_group("player"):
		target.emit_signal("heal")


func _on_heal_zone_body_exited(body):
	if body.is_in_group("player"):
		target.emit_signal("stop_heal")


func _on_hit_zone_area_entered(area):
	if area.is_in_group("enemy"):
		target.emit_signal("infect")
		area.queue_free()
