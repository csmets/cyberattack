extends Control

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/PlayContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/OptionsContainer/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CreditsContainer/HBoxContainer/Selector
onready var selector_four = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/QuitContainer/HBoxContainer/Selector

onready var play_btn = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/PlayContainer/HBoxContainer/Play_btn
onready var options_btn = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/OptionsContainer/HBoxContainer/Options_btn
onready var credits_btn = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CreditsContainer/HBoxContainer/Credits_btn
onready var quit_btn = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/QuitContainer/HBoxContainer/Quit_btn

onready var animation_player = $AnimationPlayer

var current_selection = 0

func _ready():
	set_current_selection(0)

func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 3:
		current_selection += 1
		set_current_selection(current_selection)
		animation_player.play("glitch")
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
		animation_player.play("glitch")
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)
		animation_player.play("glitch")

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_tree().change_scene("res://levels/level-1.tscn")
	elif _current_selection == 1:
		print("Add options")
	elif _current_selection == 2:
		print("Add crdits")
	elif _current_selection == 3:
		get_tree().quit()

func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	selector_four.text = ""
	play_btn.pressed = false
	options_btn.pressed = false
	credits_btn.pressed = false
	quit_btn.pressed = false
	
	if _current_selection == 0:
		selector_one.text = ">"
		play_btn.pressed = true
	elif _current_selection == 1:
		selector_two.text = ">"
		options_btn.pressed = true
	elif _current_selection == 2:
		selector_three.text = ">"
		credits_btn.pressed = true
	elif _current_selection == 3:
		selector_four.text = ">"
		quit_btn.pressed = true

func _on_Play_btn_mouse_entered():
	current_selection = 0
	set_current_selection(0)
	animation_player.play("glitch")

func _on_Options_btn_mouse_entered():
	current_selection = 1
	set_current_selection(1)
	animation_player.play("glitch")

func _on_Credits_btn_mouse_entered():
	current_selection = 2
	set_current_selection(2)
	animation_player.play("glitch")

func _on_Quit_btn_mouse_entered():
	current_selection = 3
	set_current_selection(3)
	animation_player.play("glitch")

func _on_Play_btn_pressed():
	handle_selection(0)
	animation_player.play("glitch")

func _on_Options_btn_pressed():
	handle_selection(1)
	animation_player.play("glitch")
	
func _on_Credits_btn_pressed():
	handle_selection(2)
	animation_player.play("glitch")

func _on_Quit_btn_pressed():
	handle_selection(3)
	animation_player.play("glitch")
