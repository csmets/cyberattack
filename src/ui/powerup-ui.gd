extends Control

onready var sprite = $sprite
onready var timer = $time

onready var rapid_icon = load("res://assets/tile_0012.png")
onready var multi_fire_icon = load("res://assets/tile_0013.png")

var time = 0
var start = false

func _ready():
	self.visible = false


func start_powerup(type: String, duration: float):
	reset()
	match(type):
		"Rapid":
			sprite.texture = rapid_icon
		"Multi":
			sprite.texture = multi_fire_icon
	time = duration
	self.visible = true
	start = true


func _process(delta):
	if time <= 0 and start:
		reset()
		self.visible = false
	
	if start:
		time -= delta
	
	var secs = fmod(time, 60)
	
	var time_passed = "%02ds" % secs
	
	timer.text = time_passed


func reset():
	time = 0
	start = false
