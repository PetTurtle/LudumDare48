extends Area2D

var jump_speed := 43


func _on_JumpZone_body_entered(body) -> void:
	var dwarf: KinematicBody2D = body
	dwarf.velocity.y = -jump_speed
