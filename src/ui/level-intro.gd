extends Control

signal end_level_intro

export(String) var text = ""

func _ready():
	$Label.text = text

func _process(delta):
	if Input.is_action_just_pressed("mouse_click_primary") or Input.is_action_just_pressed("ui_accept"):
		emit_signal("end_level_intro")
		queue_free()
