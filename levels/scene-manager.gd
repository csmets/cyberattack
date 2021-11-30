extends Node2D

signal clean

export(String) var retry_scene = ""
export(int) var wave_length = 0
export(float) var wave_time = 10.0
export(int) var wave_multiplier = 3
export(int) var enemies = 1

var crosshair = load("res://assets/crosshair051.png")

func _ready():
	Input.set_custom_mouse_cursor(crosshair)
	Game_data.connect("level_complete", self, "reset")
	$Enemy_manager.setup(wave_time, wave_multiplier, wave_length, enemies)
	Game_data.max_wave = wave_length
	Game_data.set_wave_count(0)

func reset():
	$Enemy_manager.reset()

func _on_Overlay_main_menu():
	Game_data.reset()
	$Enemy_manager.reset()
	get_tree().paused = false
	get_tree().change_scene("res://levels/main-menu.tscn")


func _on_Overlay_retry():
	Game_data.reset()
	$Enemy_manager.reset()
	get_tree().paused = false
	get_tree().change_scene(retry_scene)
