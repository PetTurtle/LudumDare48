extends Node

export var init_price: int = 10


func _ready() -> void:
	G.set_money(init_price)
