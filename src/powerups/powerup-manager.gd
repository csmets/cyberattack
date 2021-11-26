extends Node2D

export(String, "Rapid", "Multi") var type
export(Color) var color: Color = Color(0, 0, 0)
export(float) var rate: float = 0.0
export(float) var spread: float = 0.0
export(int) var amount: int = 1
export(float) var time: float = 1


func _ready():
	$Light2D.color = color


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Game_data.shoot_values = {
			"color": color,
			"rate": rate,
			"spread": spread,
			"amount": amount,
			"time": time,
			"type": type
		}
		get_parent().queue_free()
