extends Node2D

onready var enemy_check_time = Delta_Timer.new()

var play_action_music = false
var play_idle_music = false


func _physics_process(delta):
	if enemy_check_time.timer(delta, 1):
		var number_of_enemies = get_tree().get_nodes_in_group("enemy").size()
		
		if number_of_enemies > 10:
			play_wave()
		
		if number_of_enemies <= 10:
			play_interval()


func play_interval():
	if not play_idle_music:
		$wave_music.stop()
		$interval_music.play()
		play_idle_music = true
		play_action_music = false


func play_wave():
	if not play_action_music:
		$wave_music.play()
		$interval_music.stop()
		play_action_music = true
		play_idle_music = false
