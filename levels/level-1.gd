extends Node2D

onready var dialogue_system = $CanvasLayer/Dialogue_system

var final_dialogue = false
var computer_healed = false

func _ready():
	Game_data.connect("level_complete", self, "level_completed")
	$scene_manager.visible = false


func _on_Computer_healed():
	var healed_dialogue = [
		{
			"Name": "Roger",
			"Emotion": "Happy",
			"Text": "Great work! You've repaired the infected machine."
		},
		{
			"Name": "Roger",
			"Emotion": "Surprised",
			"Text": "Wait...What!?"
		},
		{
			"Name": "Roger",
			"Emotion": "Annoyed",
			"Text": "We have detected an incoming attack on our servers!"
		},
		{
			"Name": "Roger",
			"Emotion": "Default",
			"Text": "Use your mouse to fire bullets at the enemies. Click for a single shot, or hold to shoot rapidly."
		},
		{
			"Name": "Roger",
			"Emotion": "Default",
			"Text": "Good luck!"
		},
	]
	dialogue_system.set_dialogue(healed_dialogue)
	$Computer.queue_free()
	$Computer3.visible = true
	computer_healed = true


func level_completed():
	var level_complete_dialogue = [
		{
			"Name": "Roger",
			"Emotion": "Happy",
			"Text": "Great work! You've saved our servers from going down."
		},
		{
			"Name": "Roger",
			"Emotion": "Default",
			"Text": "We'll need your help at our larger facilities. I'll see you there!"
		}
	]
	final_dialogue = true
	dialogue_system.set_dialogue(level_complete_dialogue)


func _on_Dialogue_system_finished_dialogue():
	$scene_manager.visible = true
	if final_dialogue:
		get_tree().change_scene("res://levels/level-2.tscn")
	if computer_healed:
		Game_data.start_countdown(5)


func _on_Level_intro_end_level_intro():
	var intro_dialogue = [
		{
			"Name": "Roger",
			"Emotion": "Happy",
			"Text": "Welcome!"
		},
		{
			"Name": "Roger",
			"Emotion": "Happy",
			"Text": "You've finally made it."
		},
		{
			"Name": "Roger",
			"Emotion": "Default",
			"Text": "We need your help! We've been under attack by cyber criminals trying to take down our network."
		},
		{
			"Name": "Roger",
			"Emotion": "Angry",
			"Text": "They've found bugs in our system and are exploiting them. Planting viruses and adding randsom-wares taking down our distributed network."
		},
		{
			"Name": "Roger",
			"Emotion": "Angry",
			"Text": "We need someone with your skill-set to fight these attacks."
		},
		{
			"Name": "Roger",
			"Emotion": "Default",
			"Text": "There's an infected computer near you that needs to be repaired. Use W,A,S,D keys to run over there."
		},
		{
			"Name": "Roger",
			"Emotion": "Default",
			"Text": "Once you approach it, you'll be able to fix it."
		}
	]
	dialogue_system.set_dialogue(intro_dialogue)
