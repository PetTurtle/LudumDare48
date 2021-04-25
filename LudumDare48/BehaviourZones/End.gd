extends Area2D


func _on_Area2D_body_entered(body):
	G.end_game()
	queue_free()
