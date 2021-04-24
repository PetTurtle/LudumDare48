extends Area2D

var jump_force := 45


func _on_JumpZone_body_entered(body) -> void:
	var dwarf: PhysicsBody2D = body
	dwarf.linear_velocity.y = -jump_force
