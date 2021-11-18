extends Node
class_name Delta_Timer

var time_tracker: float = 0.0
var stop_timer: bool = false

func timer(delta: float, max_seconds: float, do_once: bool = false) -> bool:
	time_tracker += delta
	if time_tracker > max_seconds and stop_timer == false:
		time_tracker = 0.0
		if do_once:
			stop_timer = true
		return true
	return false


func reset():
	time_tracker = 0.0
