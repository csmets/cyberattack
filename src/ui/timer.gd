extends Label

var start = false
var time = 0
var score = 0

func _ready():
	Game_data.connect("countdown", self, "start_countdown")


func start_countdown(length: float):
	time = length
	start = true


func _process(delta):
	if time <= 0 and start:
		start = false
		Game_data.trigger_enemies()
		reset()
	
	if start:
		time -= delta
	
	var mils = fmod(time, 1) * 1000
	var secs = fmod(time, 60)
	var mins = fmod(time, 60 * 60) / 60
	
	var time_passed = "%02d:%02d:%03d" % [mins, secs, mils]
	var score_str = "%02d%02d%03d" % [mins, secs, mils]
	
	self.text = time_passed


func start() -> void:
	start = true


func pause() -> void:
	start = false


func reset() -> void:
	time = 0
