extends Node2D

onready var dialogue_system = $CanvasLayer/Dialogue_system

var final_dialogue = false
var start_level = false

func _ready():
	Game_data.connect("level_complete", self, "level_completed")


func _on_Level_intro_end_level_intro():
	var value = [
		{
			"Name": "Bob",
			"Emotion": "Sad",
			"Text": "You've made it! We've been under attack by a new virus."
		},
		{
			"Name": "Bob",
			"Emotion": "Default",
			"Text": "We have a lot of personal data in this facility which makes this place a high target."
		},
		{
			"Name": "Bob",
			"Emotion": "Default",
			"Text": "Please help stop the oncoming waves of attacks. Be careful!"
		}
	]
	$CanvasLayer/Dialogue_system.set_dialogue(value)
	start_level = true


func level_completed():
	var level_complete_dialogue = [
		{
			"Name": "Roger",
			"Emotion": "Happy",
			"Text": "Finally, it's over.."
		},
		{
			"Name": "Roger",
			"Emotion": "Default",
			"Text": "We need your help at another facility which requires attention to our super computers."
		}
	]
	final_dialogue = true
	dialogue_system.set_dialogue(level_complete_dialogue)


func _on_Dialogue_system_finished_dialogue():
	if final_dialogue:
		get_tree().change_scene("res://levels/level-4.tscn")
	if start_level:
		Game_data.start_countdown(5)
