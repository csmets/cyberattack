extends KinematicBody2D

export (int) var speed = 500

onready var bullet = preload("res://src/bullet/bullet.tscn")

var shooting = false

var time_tracker: float = 0.0
var stop_timer: bool = false

var delta_timer = Delta_Timer.new()
var single_shot = true


func _physics_process(delta):
	movement()
	
	
	# TODO improve shooting times
	if Input.is_action_pressed("shoot") and single_shot:
		shoot()
		single_shot = false
		shooting = true
	elif Input.is_action_pressed("shoot") and not single_shot:
		if delta_timer.timer(delta, 0.2):
			shoot()
		else:
			$AnimatedSprite/muzzle_flash.visible = false
			$AnimatedSprite/muzzle_flash_light.visible = false
		shooting = true
	else:
		shooting = false
		$AnimatedSprite/muzzle_flash.visible = false
		$AnimatedSprite/muzzle_flash_light.visible = false
	
	if Input.is_action_just_released("shoot") and not single_shot:
		single_shot = true
		shooting = false


func shoot():
	var bullet_instance = bullet.instance()
	get_tree().root.add_child(bullet_instance)
	var bullet_spawn_pos = $AnimatedSprite/End_of_gun.global_position
	bullet_instance.global_position = bullet_spawn_pos
	var target = get_global_mouse_position()
	var direction_to_mouse = bullet_instance.global_position.direction_to(target).normalized()
	bullet_instance.look_at(target)
	bullet_instance.set_direction(direction_to_mouse)
	Game_data.camera.shake(15)
	$AnimatedSprite/muzzle_flash.visible = true
	$AnimatedSprite.play("shoot")
	$AnimatedSprite/muzzle_flash_light.visible = true


func movement():
	if shooting:
		$AnimatedSprite.look_at(get_global_mouse_position())
	
	var is_moving = false
	var movement_direction := Vector2.ZERO
	var rotate = 0
	
	if Input.is_action_pressed("up"):
		movement_direction.y = -1
		rotate = -90
		is_moving = true
	if Input.is_action_pressed("down"):
		movement_direction.y = 1
		rotate = 90
		is_moving = true
	if Input.is_action_pressed("left"):
		movement_direction.x = -1
		rotate = 180
		is_moving = true
	if Input.is_action_pressed("right"):
		movement_direction.x = 1
		rotate = 0
		is_moving = true
	
	if is_moving and not shooting:
		$AnimatedSprite.rotation_degrees = rotate
	
	movement_direction = movement_direction.normalized()
	move_and_slide(movement_direction * speed)
	
	if is_moving and not shooting:
		$AnimatedSprite.play("move")
	elif not is_moving and not shooting:
		$AnimatedSprite.play("idle")
