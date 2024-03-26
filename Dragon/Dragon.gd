extends KinematicBody2D

export var kill_height = 600
export var flap_power = 400
export var gravity = 700

export var terminal_velocity = 100
export var forward_velocity = 100
export var forward_velocity_increase = 5

export var dash_velocity = 700
export var dash_duration = 0.3
export var dash_delay = 2

var current_down_velocity = 0
var current_forward_velocity = 0

var is_dashing = false
var current_dash_duration = 0

func _process(delta):
	forward_velocity += delta * forward_velocity_increase
	if !is_dashing and Input.is_action_just_pressed("flap") and position.y > 50:
		current_down_velocity = -flap_power
		$Flap.emitting = true
	if !is_dashing and Input.is_action_just_pressed("dash"):
		$Trail.emitting = true
		rotate_dragon(0)
		current_dash_duration = dash_duration
		current_down_velocity = 0
		is_dashing = true
	
	current_forward_velocity = forward_velocity
	if is_dashing:
		current_dash_duration -= delta
		if current_dash_duration < 0:
			is_dashing = false
		else:
			current_forward_velocity += dash_velocity
	else:
		current_down_velocity += clamp(gravity * delta, -flap_power, terminal_velocity)
		rotate_dragon(current_down_velocity / 15)

	var direction = Vector2(current_forward_velocity, current_down_velocity)
	move_and_slide(direction)
	check_fail()

func check_fail():
	if position.y > kill_height:
		Score.end()
		get_tree().change_scene("res://End/End.tscn")

func rotate_dragon(value):
	$AnimatedSprite.rotation_degrees = value
