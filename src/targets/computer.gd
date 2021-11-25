extends AnimatedSprite

signal healed

onready var target = $Target

export(bool) var infect = false

func _ready():
	if infect:
		target.emit_signal("infect")

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


func _on_Target_healed():
	emit_signal("healed")
