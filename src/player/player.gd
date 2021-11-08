extends KinematicBody2D

export (int) var speed = 500

onready var bullet = preload("res://src/bullet/bullet.tscn")

var shooting = false

var time_tracker: float = 0.0
var stop_timer: bool = false

func timer(delta: float, max_seconds: float, do_once: bool = false) -> bool:
	time_tracker += delta
	if time_tracker > max_seconds and stop_timer == false:
		time_tracker = 0.0
		if do_once:
			stop_timer = true
		return true
	return false

func _physics_process(delta):
	movement()
	
	if Input.is_action_pressed("shoot"):
		if timer(delta, 0.2):
			shoot()
			$muzzle_flash.visible = true
			$AnimatedSprite.play("shoot")
			$muzzle_flash_light.visible = true
		else:
			$muzzle_flash.visible = false
			$muzzle_flash_light.visible = false
		
		shooting = true
	else:
		shooting = false
		$muzzle_flash.visible = false
		$muzzle_flash_light.visible = false


func shoot():
	var bullet_instance = bullet.instance()
	get_tree().root.add_child(bullet_instance)
	var bullet_spawn_pos = $End_of_gun.global_position
	bullet_instance.global_position = bullet_spawn_pos
	var target = get_global_mouse_position()
	var direction_to_mouse = bullet_instance.global_position.direction_to(target).normalized()
	bullet_instance.look_at(target)
	bullet_instance.set_direction(direction_to_mouse)


func movement():
	look_at(get_global_mouse_position())
	
	var is_moving = false
	var movement_direction := Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		movement_direction.y = -1
		is_moving = true
	if Input.is_action_pressed("down"):
		movement_direction.y = 1
		is_moving = true
	if Input.is_action_pressed("left"):
		movement_direction.x = -1
		is_moving = true
	if Input.is_action_pressed("right"):
		movement_direction.x = 1
		is_moving = true
	
	movement_direction = movement_direction.normalized()
	move_and_slide(movement_direction * speed)
	
	if is_moving and not shooting:
		$AnimatedSprite.play("move")
	elif not is_moving and not shooting:
		$AnimatedSprite.play("idle")
