extends Area2D

onready var explosion_timer: Timer = $ExplosionTimer
onready var audio: AudioStreamPlayer = $AudioStreamPlayer
onready var particles: CPUParticles2D = $CPUParticles2D
onready var area: Area2D = $Area2D

func _on_ExplodeZone_body_entered(_body):
	collision_mask = 0
	explosion_timer.start()
	particles.emitting = true


func _on_ExplosionTimer_timeout():
	G.map.explode(global_position, 3)
	audio.ran_pitch()
	audio.play()
	visible = false
	for body in area.get_overlapping_bodies():
		body.kill()


func _on_AudioStreamPlayer_finished():
	queue_free()
