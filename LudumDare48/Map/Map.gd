extends Node2D

var sand = 0
var sand_ore = 1
var stone = 2
var stone_ore = 3
var hard_stone = 4
var hard_stone_ore = 5

var sand_bg = 0
var stone_bg = 1
var hand_stone_bg = 2

var can_mine_stone := false
var can_mine_hard_stone := false

onready var terrain_map: TileMap = $TerrainMap
onready var back_map: TileMap = $BackMap


func _init():
	G.set_map(self)


func mine_tile(point: Vector2) -> void:
	var map_point := terrain_map.world_to_map(point)
	var id = terrain_map.get_cellv(map_point)
	if (id == stone and not can_mine_stone) or (id == hard_stone and not can_mine_hard_stone):
		return
	
	if id == sand_ore:
		G.set_money(G.money + 2)
	elif id == stone_ore:
		G.set_money(G.money + 4)
	elif id == hard_stone_ore:
		G.set_money(G.money + 8)
	
	terrain_map.set_cellv(map_point, -1)
	terrain_map.update_bitmask_area(map_point)
	
	if (id == sand or id == sand_ore):
		back_map.set_cellv(map_point, sand_bg)
	if (id == stone or id == stone_ore):
		back_map.set_cellv(map_point, stone_bg)
	if (id == hard_stone or id == hard_stone_ore):
		back_map.set_cellv(map_point, hand_stone_bg)
	


func has_tile(point: Vector2) -> bool:
	var map_point := terrain_map.world_to_map(point)
	var id = terrain_map.get_cellv(map_point)
	return id != -1 and id != 7 and id != 8 and id != 9


func has_floor(point: Vector2) -> bool:
	var map_point := terrain_map.world_to_map(point)
	var id = terrain_map.get_cellv(map_point + Vector2(0, 1))
	return id != -1 and id != 7 and id != 8 and id != 9

func get_clamped(point: Vector2) -> Vector2:
	var map_point := terrain_map.world_to_map(point)
	return map_point * terrain_map.cell_size + (terrain_map.cell_size * 0.5)


func get_cell_size() -> int:
	return int(terrain_map.cell_size.x)


func explode(point: Vector2, stength: int) -> void:
	var map_point := terrain_map.world_to_map(point)
	_explode(int(map_point.x), int(map_point.y), stength)


func _explode(x: int, y: int, stength: int) -> void:
	if stength <= 0:
		return
	
	var id = terrain_map.get_cell(x, y)
	if id == sand_ore:
		G.set_money(G.money + 2)
	elif id == stone_ore:
		G.set_money(G.money + 4)
	elif id == hard_stone_ore:
		G.set_money(G.money + 8)
		
	var map_point = Vector2(x, y)
	terrain_map.set_cellv(map_point, -1)
	terrain_map.update_bitmask_area(map_point)
	
	if (id == sand or id == sand_ore):
		back_map.set_cellv(map_point, sand_bg)
	if (id == stone or id == stone_ore):
		back_map.set_cellv(map_point, stone_bg)
	if (id == hard_stone or id == hard_stone_ore):
		back_map.set_cellv(map_point, hand_stone_bg)
	
	_explode(x + 1, y, stength - 1)
	_explode(x - 1, y, stength - 1)
	_explode(x, y + 1, stength - 1)
	_explode(x, y - 1, stength - 1)
