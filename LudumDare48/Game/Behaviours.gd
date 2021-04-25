extends Node2D

export var init_price: int = 10

func _init():
	G.set_behaviours(self)

func _ready():
	G.set_money(init_price)
