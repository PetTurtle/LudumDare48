extends Area2D

onready var balloon_behaviour: PackedScene = load("res://Behaviours/BalloonBehaviour.tscn")


func _on_BalloonZone_body_entered(body):
	var dwarf: PhysicsBody2D = body
	
	if dwarf.position.x >= position.x:
		var balloon = dwarf.set_behaviour(balloon_behaviour)
		balloon.set_moving_right(false)
	else:
		var balloon = dwarf.set_behaviour(balloon_behaviour)
		balloon.set_moving_right(true)
