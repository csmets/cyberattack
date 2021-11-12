extends Sprite


func _area_entered(area: Area2D):
	area.get_parent().queue_free()
