extends Area2D

onready var walk_behaviour: PackedScene = load("res://Behaviours/WalkBehaviour.tscn")


func _on_Node2D_body_entered(body) -> void:
	var dwarf: PhysicsBody2D = body
	
	if dwarf.position.x < position.x:
		var walk = dwarf.set_behaviour(walk_behaviour)
		walk.set_moving_right(false)
	else:
		var walk = dwarf.set_behaviour(walk_behaviour)
		walk.set_moving_right(true)

