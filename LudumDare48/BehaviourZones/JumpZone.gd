extends Area2D

var jump_speed := 43
onready var sprite: AnimatedSprite = $AnimatedSprite
onready var audio: AudioStreamPlayer = $AudioStreamPlayer


func _on_JumpZone_body_entered(body) -> void:
	var dwarf: KinematicBody2D = body
	dwarf.velocity.y = -jump_speed
	sprite.play("active")
	audio.ran_pitch()
	audio.play()
