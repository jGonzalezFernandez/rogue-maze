class_name Maze
extends Node2D

# This enum must be consistent with the order of the tiles in the tile_map scene
# (and, by the way, it is better to use a scene, instead of doing everything by
# code, so it is also possible to design levels by hand in the editor)
enum Walls {NONE, W, S, SW, E, EW, ES, ESW, N, NW, NS, NSW, NE, NEW, NES, ALL}
const TILE_MAP_SCENE_PATH = ResourcePath.MAZE + "tile_map/tile_map.tscn"
const TILE_MAP_SCENE = preload(TILE_MAP_SCENE_PATH)

const HALF_TILE = 10
const TILE_SIZE = HALF_TILE * 2 # should be equal to the size of the tiles
const ROWS = 28
const COLUMNS = 51
const X_OFFSET = 0
const Y_OFFSET = 1
const MIN_X = X_OFFSET * TILE_SIZE + HALF_TILE
const MAX_X = (COLUMNS + X_OFFSET - 1) * TILE_SIZE + HALF_TILE
const MIN_Y = Y_OFFSET * TILE_SIZE + HALF_TILE
const MAX_Y = (ROWS + Y_OFFSET - 1) * TILE_SIZE + HALF_TILE
const BOTTOM_LEFT_CORNER = Vector2(MIN_X, MAX_Y)
const TOP_RIGHT_CORNER = Vector2(MAX_X, MIN_Y)
# We will divide the maze into 9 areas to balance a little the random distribution
# of the grid elements during level generation
var area_width = Utils.rounded_division(COLUMNS, 3.0)
var area_height = Utils.rounded_division(ROWS, 3.0)

var generation_algorithm: int
var add_loops: bool
var indexed_cells: Array

var astar: AStar2D
var tile_map: TileMap

func _init(generation_algorithm: int, add_loops: bool = false) -> void:
	self.generation_algorithm = generation_algorithm
	self.add_loops = add_loops

func set_cells() -> void:
	for row in ROWS:
		indexed_cells.append([])
		indexed_cells[row].resize(COLUMNS)
		for column in COLUMNS:
			var cell_id = astar.get_available_point_id()
			indexed_cells[row][column] = Cell.new(cell_id, row, column)
			astar.add_point(cell_id, Vector2((column + X_OFFSET) * TILE_SIZE + HALF_TILE, (row + Y_OFFSET) * TILE_SIZE + HALF_TILE))

func sort_cells_by_link_count_asc(cell1: Cell, cell2: Cell) -> bool:
	return cell1.link_count < cell2.link_count

func _ready() -> void:
	astar = AStar2D.new()
	set_cells()
	match generation_algorithm:
		GenerationAlgorithm.BINARY_TREE:
			BinaryTree.apply_algorithm(self)
		GenerationAlgorithm.SIDEWINDER:
			Sidewinder.apply_algorithm(self)
		GenerationAlgorithm.RECURSIVE_BACKTRACKER:
			RecursiveBacktracker.apply_algorithm(self)
		GenerationAlgorithm.RECURSIVE_DIVISION:
			RecursiveDivision.apply_algorithm(self, false)
		_:
			RecursiveDivision.apply_algorithm(self, true)
	
	if add_loops:
		for row in ROWS:
			for column in COLUMNS:
				var current_cell = indexed_cells[row][column]
				# TODO: Add an enum to select the braiding level (instead of using a hard-coded probability)?
				if current_cell.link_count <= 1 and Utils.seventy_five_percent_chance():
					var neighbours = get_neighbours_of(current_cell)
					neighbours.sort_custom(self, "sort_cells_by_link_count_asc")
					link_cells(current_cell, neighbours.front())
	
	tile_map = TILE_MAP_SCENE.instance()
	add_child(tile_map)
	draw_walls()

func north_exists(cell: Cell) -> bool:
	return cell.row > 0

func south_exists(cell: Cell) -> bool:
	return cell.row < ROWS - 1

func east_exists(cell: Cell) -> bool:
	return cell.column < COLUMNS - 1

func west_exists(cell: Cell) -> bool:
	return cell.column > 0

func get_north_cell_of(cell: Cell) -> Cell:
	return indexed_cells[cell.row - 1][cell.column]

func get_south_cell_of(cell: Cell) -> Cell:
	return indexed_cells[cell.row + 1][cell.column]

func get_east_cell_of(cell: Cell) -> Cell:
	return indexed_cells[cell.row][cell.column + 1]

func get_west_cell_of(cell: Cell) -> Cell:
	return indexed_cells[cell.row][cell.column - 1]

func get_neighbours_of(cell: Cell) -> Array:
	var neighbours = []
	if north_exists(cell):
		neighbours.append(get_north_cell_of(cell))
	if south_exists(cell):
		neighbours.append(get_south_cell_of(cell))
	if east_exists(cell):
		neighbours.append(get_east_cell_of(cell))
	if west_exists(cell):
		neighbours.append(get_west_cell_of(cell))
	return neighbours

func get_random_cell() -> Cell:
	return indexed_cells[Utils.random_int(ROWS)][Utils.random_int(COLUMNS)]

func set_walls(cell1: Cell, cell2: Cell, is_unlink: bool) -> void:
	if cell1.row == cell2.row - 1: # cell1 is north of cell2
		cell1.walls.S = is_unlink
		cell2.walls.N = is_unlink
	elif cell1.row == cell2.row + 1:
		cell1.walls.N = is_unlink
		cell2.walls.S = is_unlink
	elif cell1.column == cell2.column + 1:
		cell1.walls.W = is_unlink
		cell2.walls.E = is_unlink
	else:
		cell1.walls.E = is_unlink
		cell2.walls.W = is_unlink

func link_cells(cell1: Cell, cell2: Cell) -> void:
	astar.connect_points(cell1.id, cell2.id, true)
	set_walls(cell1, cell2, false)
	cell1.link_count += 1
	cell2.link_count += 1

func unlink_cells(cell1: Cell, cell2: Cell) -> void:
	astar.disconnect_points(cell1.id, cell2.id)
	set_walls(cell1, cell2, true)
	cell1.link_count -= 1
	cell2.link_count -= 1

func draw_walls() -> void:
	for row in ROWS:
		for column in COLUMNS:
			var current_cell = indexed_cells[row][column]
			# TODO: Use the really necessary tiles and rotate them according to the match?
			match current_cell.walls:
				{"N": false, "E": false, "S": false, "W": false}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.NONE)
				{"N": false, "E": false, "S": false, "W": true}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.W)
				{"N": false, "E": false, "S": true, "W": false}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.S)
				{"N": false, "E": false, "S": true, "W": true}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.SW)
				{"N": false, "E": true, "S": false, "W": false}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.E)
				{"N": false, "E": true, "S": false, "W": true}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.EW)
				{"N": false, "E": true, "S": true, "W": false}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.ES)
				{"N": false, "E": true, "S": true, "W": true}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.ESW)
				{"N": true, "E": false, "S": false, "W": false}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.N)
				{"N": true, "E": false, "S": false, "W": true}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.NW)
				{"N": true, "E": false, "S": true, "W": false}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.NS)
				{"N": true, "E": false, "S": true, "W": true}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.NSW)
				{"N": true, "E": true, "S": false, "W": false}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.NE)
				{"N": true, "E": true, "S": false, "W": true}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.NEW)
				{"N": true, "E": true, "S": true, "W": false}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.NES)
				{"N": true, "E": true, "S": true, "W": true}:
					tile_map.set_cell(current_cell.column + X_OFFSET, current_cell.row + Y_OFFSET, Walls.ALL)

# TODO: To avoid having to calculate all coordinates by hand, investigate whether the TileMap functions map_to_world and world_to_map can be used instead
func _random_point(factor: int, length: int, offset: int):
	return Utils.random_int(factor * length + offset, (factor - 1) * length + offset) * TILE_SIZE + HALF_TILE

func _recursion_until_valid_position(candidate_position: Vector2, excluded_positions: Array, func_ref: FuncRef) -> Vector2:
	if excluded_positions.has(candidate_position) or target_is_outside_boundaries(candidate_position): # could happen if rows or columns are not a multiple of 3
		return func_ref.call_func(excluded_positions)
	else:
		return candidate_position

func random_position(excluded_positions: Array = []) -> Vector2:
	return _recursion_until_valid_position(Vector2(_random_point(1, COLUMNS, X_OFFSET), _random_point(1, ROWS, Y_OFFSET)), excluded_positions, funcref(self, "random_position"))

func random_top_left_position(excluded_positions: Array = []) -> Vector2:
	return _recursion_until_valid_position(Vector2(_random_point(1, area_width, X_OFFSET), _random_point(1, area_height, Y_OFFSET)), excluded_positions, funcref(self, "random_top_left_position"))

func random_top_center_position(excluded_positions: Array = []) -> Vector2:
	return _recursion_until_valid_position(Vector2(_random_point(2, area_width, X_OFFSET), _random_point(1, area_height, Y_OFFSET)), excluded_positions, funcref(self, "random_top_center_position"))

func random_top_right_position(excluded_positions: Array = []) -> Vector2:
	return _recursion_until_valid_position(Vector2(_random_point(3, area_width, X_OFFSET), _random_point(1, area_height, Y_OFFSET)), excluded_positions, funcref(self, "random_top_right_position"))

func random_center_left_position(excluded_positions: Array = []) -> Vector2:
	return _recursion_until_valid_position(Vector2(_random_point(1, area_width, X_OFFSET), _random_point(2, area_height, Y_OFFSET)), excluded_positions, funcref(self, "random_center_left_position"))

func random_center_position(excluded_positions: Array = []) -> Vector2:
	return _recursion_until_valid_position(Vector2(_random_point(2, area_width, X_OFFSET), _random_point(2, area_height, Y_OFFSET)), excluded_positions, funcref(self, "random_center_position"))

func random_center_right_position(excluded_positions: Array = []) -> Vector2:
	return _recursion_until_valid_position(Vector2(_random_point(3, area_width, X_OFFSET), _random_point(2, area_height, Y_OFFSET)), excluded_positions, funcref(self, "random_center_right_position"))

func random_bottom_center_position(excluded_positions: Array = []) -> Vector2:
	return _recursion_until_valid_position(Vector2(_random_point(2, area_width, X_OFFSET), _random_point(3, area_height, Y_OFFSET)), excluded_positions, funcref(self, "random_bottom_center_position"))

func random_bottom_right_position(excluded_positions: Array = []) -> Vector2:
	return _recursion_until_valid_position(Vector2(_random_point(3, area_width, X_OFFSET), _random_point(3, area_height, Y_OFFSET)), excluded_positions, funcref(self, "random_bottom_right_position"))

static func target_is_outside_boundaries(target: Vector2) -> bool:
	return target.x < MIN_X or target.x > MAX_X or target.y < MIN_Y or target.y > MAX_Y
