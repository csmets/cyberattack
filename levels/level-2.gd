extends Node2D

func _ready():
	var value = [
		{
			"Name": "Bob",
			"Emotion": "Happy",
			"Text": "It works!"
		},
		{
			"Name": "Bob",
			"Emotion": "Angry",
			"Text": "Do you like that bitch!"
		},
	]
	$CanvasLayer/Dialogue_system.set_dialogue(value)
