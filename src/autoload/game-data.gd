extends Node

signal Wave_updated(number)
signal Infected_updated(number)
signal countdown(length)
signal spawn_enemies

var wave_count = 0 setget set_wave_count
var infected_count = 0 setget set_infected_count


func set_wave_count(value: int):
	wave_count = value
	emit_signal("Wave_updated", value)


func set_infected_count(value: int):
	infected_count = value
	emit_signal("Infected_updated", value)


func start_countdown(length: float):
	emit_signal("countdown", length)


func trigger_enemies():
	emit_signal("spawn_enemies")
