extends Area2D

onready var explosion = preload("res://src/explosions/explosion.tscn")


func _on_Enemy_projectile_area_entered(area):
	if area.is_in_group("bullet"):
		var explosion_instance = explosion.instance()
		get_tree().root.add_child(explosion_instance)
		explosion_instance.position = self.global_position
		Game_data.camera.shake(300, 1, 150)
		self.queue_free()
		area.queue_free()

