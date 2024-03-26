extends Area2D

export var value = 10
var collected = false

func _on_Collectible_body_entered(body):
	if collected:
		return
	
	Score.add(value)
	collected = true
	$AnimationPlayer.play("Collect")
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
