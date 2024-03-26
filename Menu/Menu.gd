extends Node2D

export var speed = 400

var game_is_starting = false

func _ready():
	$AnimationPlayer.play("Wiggle")
	$Flap/Flap2.play("Flap")
	$Dash/Dash2.play("Dash")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_is_starting:
		$AnimatedSprite.position = Vector2($AnimatedSprite.position.x, $AnimatedSprite.position.y - delta * speed)
		
func _input(event):
	if game_is_starting:
		return
	if event.is_action_pressed("flap"):
		start_game()
		
func start_game():
	game_is_starting = true
	$AnimationPlayer.stop()
	$AnimatedSprite.play("fly")
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().change_scene("res://Main/Main.tscn")
