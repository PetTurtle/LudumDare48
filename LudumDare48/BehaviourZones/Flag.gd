extends Area2D

export var active := false
export var unlock_stone := false
export var unlock_hard_stone := false

onready var sprite: AnimatedSprite = $AnimatedSprite
onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	if active:
		sprite.play("raised")
		G.set_flag(self)


func _on_Flag_body_entered(_body):
	if not active:
		active = true
		sprite.play("raised")
		audio.ran_pitch()
		audio.play()
		G.set_flag(self)
		
		if unlock_stone:
			G.map.can_mine_stone = true
		if unlock_hard_stone:
			G.map.can_mine_hard_stone = true
