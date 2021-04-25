extends Node2D

onready var tomb_scene: PackedScene = preload("res://BehaviourZones/Tomb.tscn")


func _init():
	G.set_dwarfs(self)


func spawn_gore(point: Vector2):
	var tomb: RigidBody2D= tomb_scene.instance()
	add_child(tomb)
	tomb.position = point
	tomb.add_central_force(Vector2(rand_range(-10, 10), rand_range(10, 100)))

