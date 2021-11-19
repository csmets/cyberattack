extends Node

signal Wave_updated(number)
signal Infected_updated(number)
signal countdown(length)
signal spawn_enemies
signal update_shoot(values)
signal spawn_powerups
signal Infect

var wave_count = 0 setget set_wave_count
var infected_count = 0 setget set_infected_count
var shoot_values = {
	"color": Color(0, 0, 0),
	"rate": 0.0,
	"spread": 0.0,
	"amount": 1,
	"time": 1
} setget set_shoot_values

var camera = null

func set_wave_count(value: int):
	wave_count = value
	emit_signal("Wave_updated", value)


func set_infected_count(value: int):
	infected_count = value
	emit_signal("Infected_updated", value)


func start_countdown(length: float):
	emit_signal("countdown", length)


func spawn_powerups(wave: int):
	emit_signal("spawn_powerups", wave)


func trigger_enemies():
	emit_signal("spawn_enemies")


func trigger_infect():
	emit_signal("Infect")


func set_shoot_values(value: Dictionary):
	shoot_values = value
	emit_signal("update_shoot", value)
