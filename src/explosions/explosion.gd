extends AnimatedSprite

var delta_timer = Delta_Timer.new()

func _ready():
	self.play("explode")
	$AudioStreamPlayer2D.play()

func _process(delta):
	if delta_timer.timer(delta, 5):
		queue_free()
