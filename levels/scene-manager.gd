extends Node2D

export(int) var wave_length = 0
export(float) var wave_time = 10.0
export(int) var wave_multiplier = 3
export(int) var enemies = 1

func _ready():
	$Enemy_manager.setup(wave_time, wave_multiplier, wave_length, enemies)
	Game_data.max_wave = wave_length
	Game_data.set_wave_count(0)
