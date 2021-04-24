extends Area2D

onready var explosion_timer: Timer = $ExplosionTimer

func _on_ExplodeZone_body_entered(_body):
	collision_mask = 0
	explosion_timer.start()



func _on_ExplosionTimer_timeout():
	G.map.explode(global_position, 4)
	queue_free()
