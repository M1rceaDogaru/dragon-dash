extends Area2D

func _on_Obstacle_body_entered(body):
	Score.end()
	get_tree().change_scene("res://End/End.tscn")
