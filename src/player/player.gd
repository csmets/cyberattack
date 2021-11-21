extends KinematicBody2D

export (int) var speed = 200

onready var bullet = preload("res://src/bullet/bullet.tscn")

var shooting = false

var time_tracker: float = 0.0
var stop_timer: bool = false

var delta_timer = Delta_Timer.new()
var single_shot = true
var use_powerup = false
var powerup_values = null
var powerup_timer = Delta_Timer.new()

func _ready():
	Game_data.connect("update_shoot", self, "update_shoot_values")


func update_shoot_values(values):
	powerup_values = values
	use_powerup = true
	$AudioStreamPlayer2D.play()
	powerup_timer.reset()


func _physics_process(delta):
	movement()
	
	if use_powerup and powerup_timer.timer(delta, powerup_values.time):
		use_powerup = false
	
	if Input.is_action_pressed("shoot") and use_powerup:
		shoot(delta, powerup_values.rate, powerup_values.spread, powerup_values.amount, powerup_values.color)
		shooting = true
	elif Input.is_action_pressed("shoot") and single_shot:
		shoot(delta, 0, 0, 1)
		single_shot = false
		shooting = true
	elif Input.is_action_pressed("shoot") and not single_shot:
		shoot(delta, 0.2, 0, 1)
		shooting = true
	else:
		shooting = false
		$AnimatedSprite/muzzle_flash.visible = false
		$AnimatedSprite/muzzle_flash_light.visible = false
	
	if Input.is_action_just_released("shoot") and not single_shot:
		single_shot = true
		shooting = false


func shoot(delta: float, rate: float, spread: float, amount: int, color = null):
	if delta_timer.timer(delta, rate):
		
		for num in range(amount):
			var bullet_instance = bullet.instance()
			get_tree().root.add_child(bullet_instance)
			var bullet_spawn_pos = $AnimatedSprite/End_of_gun.global_position
			bullet_instance.global_position = bullet_spawn_pos
			var target = get_global_mouse_position()
			var direction_to_mouse = bullet_instance.global_position.direction_to(target).normalized()
			bullet_instance.look_at(target)
			if spread > 0 and amount > 1:
				var degree = (spread / (amount - 1)) * num
				bullet_instance.rotation_degrees = bullet_instance.rotation_degrees - (spread / 2) + degree
			
			if color != null:
				bullet_instance.modulate = color
			
		Game_data.camera.shake(1.4)
		$AnimatedSprite/muzzle_flash.visible = true
		$AnimatedSprite.play("shoot")
		$AnimatedSprite/muzzle_flash_light.visible = true
	else:
		$AnimatedSprite/muzzle_flash.visible = false
		$AnimatedSprite/muzzle_flash_light.visible = false

var play_footstep = false

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
		
	if is_moving and not play_footstep:
		play_footstep = true
		$footsteps.play()
	elif not is_moving:
		play_footstep = false
		$footsteps.stop()
	
	if is_moving and not shooting:
		$AnimatedSprite.rotation_degrees = rotate
	
	movement_direction = movement_direction.normalized()
	move_and_slide(movement_direction * speed)
	
	if is_moving and not shooting:
		$AnimatedSprite.play("move")
	elif not is_moving and not shooting:
		$AnimatedSprite.play("idle")
