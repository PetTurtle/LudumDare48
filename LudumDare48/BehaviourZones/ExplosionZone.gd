extends Area2D

onready var explosion_behaviour: PackedScene = load("res://Behaviours/WalkBehaviour.tscn")


func _on_Node2D_body_entered(body) -> void:
	var dwarf: PhysicsBody2D = body
	
	if dwarf.position.x < position.x:
		var explosion = dwarf.set_behaviour(explosion_behaviour)
		explosion.set_moving_right(false)
	else:
		var explosion = dwarf.set_behaviour(explosion_behaviour)
		explosion.set_moving_right(true)
