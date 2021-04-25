extends Area2D

onready var explosion_timer: Timer = $ExplosionTimer
onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _on_ExplodeZone_body_entered(_body):
	collision_mask = 0
	explosion_timer.start()


func _on_ExplosionTimer_timeout():
	G.map.explode(global_position, 4)
	audio.ran_pitch()
	audio.play()
	visible = false
	


func _on_AudioStreamPlayer_finished():
	queue_free()
