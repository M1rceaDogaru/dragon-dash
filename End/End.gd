extends Node2D

export var restart_delay = 1.5
export var speed = 400

var restart_delay_time = 0.0
var game_is_starting = false

func _ready():
	$AnimationPlayer.play("Wiggle")
	$Score.text = str(int(Score.current_score))
	$High.text = str(int(Score.high_score))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if restart_delay_time < restart_delay:
		restart_delay_time += delta
	
	if game_is_starting:
		$AnimatedSprite.position = Vector2($AnimatedSprite.position.x, $AnimatedSprite.position.y - delta * speed)
		
func _input(event):
	if restart_delay_time < restart_delay:
		return
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
