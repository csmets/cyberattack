extends Control

signal finished_dialogue

onready var dialog_box = $Dialogue_box
onready var timer = $Dialogue_box/Timer
onready var character_name = $Dialogue_box/Name
onready var text = $Dialogue_box/Dialogue
onready var indicator = $Dialogue_box/Next
onready var character = $Dialogue_box/Character/Sprite

var default = load("res://assets/characters/Masculine_A/Masculine_A_default.png")
var happy = load("res://assets/characters/Masculine_A/Masculine_A_happy.png")
var angry = load("res://assets/characters/Masculine_A/Masculine_A_angry.png")
var sad = load("res://assets/characters/Masculine_A/Masculine_A_sad.png")
var annoyed = load("res://assets/characters/Masculine_A/Masculine_A_annoyed.png")
var surprised = load("res://assets/characters/Masculine_A/Masculine_A_surprised.png")

export(float) var textSpeed = 0.05

var dialogue

var phraseNum = 0
var finished = false
var start_dialog = false

func _ready():
	dialog_box.visible = false
	get_tree().paused = true

func set_dialogue(value):
	get_tree().paused = true
	self.dialogue = value
	dialog_box.visible = true
	timer.wait_time = textSpeed
	start_dialog = true
	phraseNum = 0
	nextPhrase()

func _process(_delta):
	indicator.visible = finished
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("mouse_click_primary")) and start_dialog:
		if finished:
			nextPhrase()
		else:
			text.visible_characters = len(text.text)

func nextPhrase() -> void:
	if phraseNum >= len(dialogue):
		get_tree().paused = false
		dialog_box.visible = false
		start_dialog = false
		emit_signal("finished_dialogue")
		return
	
	finished = false
	
	character_name.bbcode_text = dialogue[phraseNum]["Name"]
	text.bbcode_text = dialogue[phraseNum]["Text"]
	
	text.visible_characters = 0
	
	var f = File.new()
	var emotion = dialogue[phraseNum]["Emotion"]
	match(emotion):
		"Default":
			character.texture = default
		"Happy":
			character.texture = happy
		"Angry":
			character.texture = angry
		"Sad":
			character.texture = sad
		"Annoyed":
			character.texture = annoyed
		"Surprised":
			character.texture = surprised
	
	while text.visible_characters < len(text.text):
		text.visible_characters += 1
		
		timer.start()
		yield(timer, "timeout")
	
	finished = true
	phraseNum += 1
	return
