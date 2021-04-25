extends RigidBody2D



func _on_Area2D_body_entered(body):
	if linear_velocity.y > 0:
		body.kill()
