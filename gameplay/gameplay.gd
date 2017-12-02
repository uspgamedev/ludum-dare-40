extends Node2D

onready var input = get_node('/root/input')

func _ready():
	input.connect('press_quit', self, 'quit')

func quit():
	get_tree().quit()

func get_size():
	return Vector2(1280, 720)

func get_valid_position():
	var wall_tile_map = get_node("Props")
	var floor_tile_map = get_node("Floor")
	var cells = floor_tile_map.get_used_cells()
	var cell = cells[randi()%cells.size()]
	while floor_tile_map.get_cell(cell.x, cell.y) == 3 or wall_tile_map.get_cell(cell.x, cell.y) != -1:
		cell = cells[randi()%cells.size()]
	return wall_tile_map.map_to_world(cell) + Vector2(12, 24)

func is_a_valid_position(pos):
	var floor_tile_map = get_node("Floor")
	var cell = floor_tile_map.get_cell(floor_tile_map.world_to_map(pos).x, \
	                                   floor_tile_map.world_to_map(pos).y)
	if (cell == 3 or cell != -1):
		return true
	return false
