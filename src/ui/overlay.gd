extends Control

var play_glitch = false

func _ready():
	$game_over.visible = false
	$Control.visible = false
	
	Game_data.connect("Infected_updated", self, "update_infected_count")
	Game_data.connect("Wave_updated", self, "update_wave_count")
	Game_data.connect("Infect", self, "play_glitch")
	
	$Timer.start()


func update_infected_count(value: int):
	$infected.text = "No. of deviced infected: %s" % value


func play_glitch():
	Game_data.camera.shake(500, 1, 150)
	$Control/AnimationPlayer.play("displace")
	play_glitch = true


func update_wave_count(value: int):
	$wave.text = "Wave: %s" % value


func _physics_process(delta):
	var number_of_targets = get_tree().get_nodes_in_group("target").size()
	
	if Game_data.infected_count == number_of_targets:
		$game_over.visible = true
		get_tree().paused = true
	
	if play_glitch:
		$Control.visible = true
		
		if not $Control/AnimationPlayer.is_playing():
			$Control.visible = false
			play_glitch = false
