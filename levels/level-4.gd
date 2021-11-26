extends Node2D

onready var dialogue_system = $CanvasLayer/Dialogue_system

var super_computer_story = false
var final_dialogue = false
var start_level = false

func _ready():
	Game_data.connect("level_complete", self, "level_completed")

func _on_Super_computer_healed():
	if not super_computer_story:
		super_computer_story = true
		var value = [
			{
				"Name": "Bob",
				"Emotion": "Happy",
				"Text": "Great work!"
			},
			{
				"Name": "Bob",
				"Emotion": "Angry",
				"Text": "Let's attack the incoming wave of viruses!"
			}
		]
		$CanvasLayer/Dialogue_system.set_dialogue(value)


func _on_Dialogue_system_finished_dialogue():
	if final_dialogue:
		get_tree().change_scene("res://levels/level-5.tscn")
	if start_level:
		Game_data.start_countdown(10)


func _on_Level_intro_end_level_intro():
	var value = [
		{
			"Name": "Bob",
			"Emotion": "Default",
			"Text": "Hey, we need to protect our super computers from infection."
		},
		{
			"Name": "Bob",
			"Emotion": "Sad",
			"Text": "Our super computer in this facility has been infected. It needs to be fixed before the next wave hits, otherwise it's game over for us."
		}
	]
	$CanvasLayer/Dialogue_system.set_dialogue(value)
	start_level = true


func level_completed():
	var level_complete_dialogue = [
		{
			"Name": "Roger",
			"Emotion": "Happy",
			"Text": "You...you did it!!"
		},
		{
			"Name": "Roger",
			"Emotion": "Default",
			"Text": "You know the drill...see you at the next facility."
		}
	]
	final_dialogue = true
	dialogue_system.set_dialogue(level_complete_dialogue)
