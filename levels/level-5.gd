extends Node2D

onready var dialogue_system = $CanvasLayer/Dialogue_system

var final_dialogue = false
var start_level = false

func _ready():
	Game_data.connect("level_complete", self, "level_completed")
	
func _on_Dialogue_system_finished_dialogue():
	$scene_manager.visible = true
	if final_dialogue:
		get_tree().change_scene("res://levels/boss-level.tscn")
	if start_level:
		Game_data.start_countdown(5)


func _on_Level_intro_end_level_intro():
	var value = [
		{
			"Name": "Bob",
			"Emotion": "Default",
			"Text": "I've gotten intel that a new virus is out to target us."
		},
		{
			"Name": "Bob",
			"Emotion": "Default",
			"Text": "I wish you best of luck!"
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
