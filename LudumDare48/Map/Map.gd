extends Node2D

onready var terrain_map: TileMap = $TerrainMap
onready var background_map: TileMap = $BackgroundMap 


func _init():
	G.set_map(self)


func mine_tile(point: Vector2) -> void:
	var map_point := terrain_map.world_to_map(point)
	terrain_map.set_cellv(map_point, -1)


func get_tile(point: Vector2) -> int:
	var map_point := terrain_map.world_to_map(point)
	return terrain_map.get_cellv(map_point)


func has_floor(point: Vector2) -> bool:
	var map_point := terrain_map.world_to_map(point)
	return terrain_map.get_cellv(map_point + Vector2(0, 1)) != -1

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
	
	terrain_map.set_cell(x, y, -1)
	_explode(x + 1, y, stength - 1)
	_explode(x - 1, y, stength - 1)
	_explode(x, y + 1, stength - 1)
	_explode(x, y - 1, stength - 1)
