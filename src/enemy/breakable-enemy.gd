extends Node2D

onready var explosion = preload("res://src/explosions/explosion.tscn")

onready var p1 = $p1_area
onready var p2 = $p2_area
onready var p3 = $p3_area
onready var p4 = $p4_area

var total_parts = 4
var parts = 0

signal destroy

func add_explosion():
	var explosion_instance = explosion.instance()
	get_tree().root.add_child(explosion_instance)
	explosion_instance.position = self.global_position
	Game_data.camera.shake(300, 1, 150)


func bullet_hit(area, p_num):
	if area.is_in_group("bullet"):
		add_explosion()
		parts += 1
		emit_signal("destroy")
		area.queue_free()
		
		match(p_num):
			1:
				p1.queue_free()
			2:
				p2.queue_free()
			3:
				p3.queue_free()
			4:
				p4.queue_free()


func _on_p1_area_area_entered(area):
	bullet_hit(area, 1)


func _on_p2_area_area_entered(area):
	bullet_hit(area, 2)


func _on_p3_area_area_entered(area):
	bullet_hit(area, 3)


func _on_p4_area_area_entered(area):
	bullet_hit(area, 4)


func _on_Breakable_enemy_destroy():
	if parts >= 4:
		self.queue_free()
