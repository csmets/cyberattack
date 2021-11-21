extends Node2D

func _ready():
	$interval_music.play()
	Game_data.connect("countdown", self, "play_interval")
	Game_data.connect("Wave_updated", self, "play_wave")


func play_interval(value):
	$wave_music.stop()
	$interval_music.play()


func play_wave(value):
	$wave_music.play()
	$interval_music.stop()
