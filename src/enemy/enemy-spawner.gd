extends Area2D

onready var explosion = preload("res://src/explosions/explosion.tscn")
onready var projectile = preload("res://src/enemy/enemy-projectile.tscn")

var delta_timer = Delta_Timer.new()
var spawn_time := 3.0

var enemy_spawner_spawned = false


func _physics_process(delta):
	if enemy_spawner_spawned:
		if delta_timer.timer(delta, spawn_time):
			var projectile_instance = projectile.instance()
			get_tree().root.add_child(projectile_instance)
			projectile_instance.global_position = self.position


func _on_Enemy_spawner_area_entered(area):
	if area.is_in_group("bullet"):
		var explosion_instance = explosion.instance()
		get_parent().add_child(explosion_instance)
		explosion_instance.position = self.global_position
		Game_data.camera.shake(300, 1, 150)
		self.queue_free()
		area.queue_free()


func _on_Enemy_movement_spawned():
	enemy_spawner_spawned = true
	delta_timer.reset()
