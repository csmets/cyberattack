extends Node2D

onready var dialogue_system = $CanvasLayer/Dialogue_system

var final_dialogue = false
var start_level = false

func _ready():
	Game_data.connect("level_complete", self, "level_completed")


func level_completed():
	var level_complete_dialogue = [
		{
			"Name": "Roger",
			"Emotion": "Happy",
			"Text": "Amazing work! You really are talented."
		},
		{
			"Name": "Roger",
			"Emotion": "Default",
			"Text": "I think you're ready to take on some bigger challenges."
		}
	]
	final_dialogue = true
	dialogue_system.set_dialogue(level_complete_dialogue)


func _on_Dialogue_system_finished_dialogue():
	if final_dialogue:
		get_tree().change_scene("res://levels/level-3.tscn")
	if start_level:
		Game_data.start_countdown(5)


func _on_Level_intro_end_level_intro():
	var value = [
		{
			"Name": "Bob",
			"Emotion": "Happy",
			"Text": "Welcome to our facility #313."
		},
		{
			"Name": "Bob",
			"Emotion": "Default",
			"Text": "We have received intel that there will be an attack on this facility soon."
		},
		{
			"Name": "Bob",
			"Emotion": "Default",
			"Text": "I've provided you with boosts that will appear after each attack wave. These boost will help you fight these viruses but they only last for a short time."
		},
		{
			"Name": "Bob",
			"Emotion": "Default",
			"Text": "Good luck!"
		}
	]
	$CanvasLayer/Dialogue_system.set_dialogue(value)
	start_level = true
