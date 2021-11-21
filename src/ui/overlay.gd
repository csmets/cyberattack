extends CanvasLayer

var play_glitch = false

func _ready():
	$Control2/game_over.visible = false
	$Control2/Control/ColorRect.visible = false
	
	Game_data.connect("Infected_updated", self, "update_infected_count")
	Game_data.connect("Wave_updated", self, "update_wave_count")
	Game_data.connect("Infect", self, "play_glitch")
	
	$Control2/Timer.start()


func update_infected_count(value: int):
	$Control2/infected.text = "No. of deviced infected: %s" % value


func play_glitch():
	Game_data.camera.shake(500, 1, 150)
	$Control2/Control/AnimationPlayer.play("displace")
	play_glitch = true


func update_wave_count(value: int):
	$Control2/wave.text = "Wave: %s" % value


func _physics_process(delta):
	var number_of_targets = get_tree().get_nodes_in_group("target").size()
	
	if Game_data.infected_count == number_of_targets:
		$Control2/game_over.visible = true
		get_tree().paused = true
	
	if play_glitch:
		$Control2/Control/ColorRect.visible = true
		
		if not $Control2/Control/AnimationPlayer.is_playing():
			$Control2/Control/ColorRect.visible = false
			play_glitch = false
