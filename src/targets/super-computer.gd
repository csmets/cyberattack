extends AnimatedSprite

onready var target = $Target

var healed = true

func _ready():
	Game_data.connect("spawn_enemies", self, "heal_status")

# Check if super computer is healed before next wave, if it's not, it's game over.
func heal_status():
	if not healed:
		Game_data.game_over()


func _on_hit_zone_area_entered(area):
	if area.is_in_group("enemy"):
		target.emit_signal("infect")
		area.queue_free()
		healed = false


func _on_healzone_body_entered(body):
	if body.is_in_group("player"):
		target.emit_signal("heal")


func _on_healzone_body_exited(body):
	if body.is_in_group("player"):
		target.emit_signal("stop_heal")


func _on_Target_healed():
	healed = true
