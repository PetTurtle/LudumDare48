extends Node

export var init_price: int = 25


func _ready() -> void:
	G.set_money(init_price)
	G.spawn_dwarf()
