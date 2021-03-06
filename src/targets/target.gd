extends Node2D

export(Color) var infected_color := Color(1, 0.1, 0.1)
export(float) var repair_time := 0.5 #seconds

onready var progress_bar = $progress_bar
onready var bar = $progress_bar/over

var _infected := false

var health := 100
var repair = false

var delta_timer = Delta_Timer.new()

var sprite

signal infect
signal heal
signal stop_heal
signal healed


func _ready():
	sprite = get_parent()
	progress_bar.visible = false
	progress_bar.global_rotation = 0
	self.connect("heal", self, "repair_target")
	self.connect("infect", self, "infect_target")
	self.connect("stop_heal", self, "stop_repair_target")


func repair_target():
	if is_infected():
		repair = true
		progress_bar.visible = true


func infect_target():
	if not is_infected():
		sprite.self_modulate = infected_color
		_infected = true
		health = 0
		$infected.play()
		Game_data.infected_count += 1
		Game_data.trigger_infect()


func stop_repair_target():
	if is_infected():
		repair = false
		progress_bar.visible = false
		if health < 100:
			health = 0
			bar.scale.x = 0


func is_infected() -> bool:
	return _infected


func _physics_process(delta):
	_repair(delta)


func _repair(delta: float):
	if repair:
		if delta_timer.timer(delta, repair_time):
			health += 10
			bar.scale.x = (health / 2) * -1
			$healing.play()
		
		if health >= 100:
			health = 100
			progress_bar.visible = false
			bar.scale.x = 0
			_infected = false
			repair = false
			sprite.self_modulate = Color(1, 1, 1)
			$healed.play()
			Game_data.infected_count -= 1
			emit_signal("healed")
