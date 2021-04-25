extends Node2D
class_name Behaviour

var dwarf: KinematicBody2D


func _ready() -> void:
	dwarf = get_parent()
