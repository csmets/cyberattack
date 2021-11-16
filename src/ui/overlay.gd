extends Control

func _ready():
	$game_over.visible = false
	
	Game_data.connect("Infected_updated", self, "update_infected_count")
	Game_data.connect("Wave_updated", self, "update_wave_count")
	
	$Timer.start()


func update_infected_count(value: int):
	$infected.text = "No. of deviced infected: %s" % value


func update_wave_count(value: int):
	$wave.text = "Wave: %s" % value


func _physics_process(delta):
	var number_of_targets = get_tree().get_nodes_in_group("target").size()
	
	if Game_data.infected_count == number_of_targets:
		$game_over.visible = true
		get_tree().paused = true
