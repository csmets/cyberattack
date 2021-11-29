extends Node2D

onready var dialogue_system = $CanvasLayer/Dialogue_system

var start_level = false
var final_dialogue = false

var boss_health = 50

onready var health_bar_progress = $Boss/progress_bar/over
onready var damage_timer = $Timer
onready var health_bar = $Boss/progress_bar
onready var hit_timer = $Hit_timer
onready var boss = $Boss

var boss_shield = false

signal boss_damage

func _ready():
	Game_data.connect("level_complete", self, "level_completed")
	Game_data.connect("countdown", self, "shield_boss")
	Game_data.connect("Wave_updated", self, "unshield_boss")
	health_bar.visible = false


func level_completed():
	var level_complete_dialogue = [
		{
			"Name": "Roger",
			"Emotion": "Surprised",
			"Text": "You've done it!"
		},
		{
			"Name": "Roger",
			"Emotion": "Happy",
			"Text": "You've wiped out the virus that's been compromising our systems."
		},
		{
			"Name": "Roger",
			"Emotion": "Happy",
			"Text": "I don't know how we would have been able to stop this virus from spreaking without your help. You'll hear from us again."
		}
	]
	final_dialogue = true
	dialogue_system.set_dialogue(level_complete_dialogue)


func _on_Dialogue_system_finished_dialogue():
	if final_dialogue:
		get_tree().change_scene("res://levels/main-menu.gd")
	if start_level:
		Game_data.start_countdown(0)


func _on_Level_intro_end_level_intro():
	var value = [
		{
			"Name": "Bob",
			"Emotion": "Surprised",
			"Text": "What? what is this?!"
		},
		{
			"Name": "Bob",
			"Emotion": "Sad",
			"Text": "We are doomed!"
		}
	]
	$CanvasLayer/Dialogue_system.set_dialogue(value)
	start_level = true


func _on_Boss_area_entered(area):
	if area.is_in_group("bullet") and not boss_shield and not final_dialogue:
		area.queue_free()
		emit_signal("boss_damage")


func _on_Boss_level_boss_damage():
	boss_health -= 0.1
	health_bar_progress.scale.x = boss_health * -1
	damage_timer.start()
	hit_timer.start()
	health_bar.visible = true
	if not boss_shield:
		boss.modulate = Color(100, 100, 100)
	
	if boss_health <= 0:
		Game_data.level_complete()


func _on_Timer_timeout():
	health_bar.visible = false


func _on_Hit_timer_timeout():
	if not boss_shield:
		boss.modulate = Color(1, 1, 1)


func shield_boss(length):
	boss_shield = true
	boss.modulate = Color (0, 0, 0)


func unshield_boss(number):
	boss_shield = false
	boss.modulate = Color (1, 1, 1)
