extends CanvasLayer

signal retry
signal main_menu

var play_glitch = false
var _retry_scene
var is_game_over = false

func _ready():
	$Control2.visible = false
	$game_over.visible = false
	$Glitch.visible = false
	$Pause.visible = false
	
	Game_data.connect("Infected_updated", self, "update_infected_count")
	Game_data.connect("Wave_updated", self, "update_wave_count")
	Game_data.connect("Infect", self, "play_glitch")
	Game_data.connect("game_over", self, "game_over")
	Game_data.connect("countdown", self, "show_ui")
	Game_data.connect("update_shoot", self, "show_power_up")


func show_ui(value):
	$Control2.visible = true


func show_power_up(value):
	print("POWERUP")
	var type = value.type
	var time = value.time
	$Control2/Powerup_UI.start_powerup(type, time)
	

func update_infected_count(value: int):
	$Control2/infected.text = "Deviced infected: %s" % value


func play_glitch():
	Game_data.camera.shake(500, 1, 150)
	$AnimationPlayer.play("displace")
	play_glitch = true


func update_wave_count(value: int):
	$Control2/wave.text = "Wave: %s/%s" % [value, Game_data.max_wave]


func game_over():
	$game_over.visible = true
	$Control2.visible = false
	get_tree().paused = true


func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		$Pause.visible = true


func _physics_process(delta):
	var number_of_targets = get_tree().get_nodes_in_group("target").size()
	
	if Game_data.infected_count == number_of_targets and not is_game_over:
		Game_data.game_over()
		is_game_over = true
	
	if play_glitch:
		$Glitch.visible = true
		
		if not $AnimationPlayer.is_playing():
			$Glitch.visible = false
			play_glitch = false


func _on_Main_menu_pressed():
	emit_signal("main_menu")


func _on_Retry_pressed():
	emit_signal("retry")


func _on_Continue_pressed():
	$Pause.visible = false
	get_tree().paused = false


func _on_pause_Retry_pressed():
	emit_signal("retry")


func _on_pause_Main_menu_pressed():
	emit_signal("main_menu")
