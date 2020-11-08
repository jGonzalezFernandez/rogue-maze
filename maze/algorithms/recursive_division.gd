class_name RecursiveDivision

static func randomly_build_room(height: int, width: int) -> bool:
	return height < 5 and width < 5 and Utils.twenty_five_percent_chance()

static func horizontal_cut(maze, row: int, column: int, height: int, width: int, with_rooms: bool) -> void:
	var cut_position     = Utils.random_int(height - 1)
	var passage_position = Utils.random_int(width)

	for x in width:
		if x != passage_position:
			var current_cell = maze.indexed_cells[row + cut_position][column + x]
			if maze.south_exists(current_cell):
				maze.unlink_cells(current_cell, maze.get_south_cell_of(current_cell))

	divide(maze, row, column, cut_position + 1, width, with_rooms)
	divide(maze, row + cut_position + 1, column, height - cut_position - 1, width, with_rooms)

static func vertical_cut(maze, row: int, column: int, height: int, width: int, with_rooms: bool) -> void:
	var cut_position     = Utils.random_int(width - 1)
	var passage_position = Utils.random_int(height)

	for y in height:
		if y != passage_position:
			var current_cell = maze.indexed_cells[row + y][column + cut_position]
			if maze.east_exists(current_cell):
				maze.unlink_cells(current_cell, maze.get_east_cell_of(current_cell))

	divide(maze, row, column, height, cut_position + 1, with_rooms)
	divide(maze, row, column + cut_position + 1, height, width - cut_position - 1, with_rooms)

static func divide(maze, row: int, column: int, height: int, width: int, with_rooms: bool) -> void:
	if height <= 1 or width <= 1 or (with_rooms and randomly_build_room(height, width)):
		 pass
	elif height > width:
		 horizontal_cut(maze, row, column, height, width, with_rooms)
	else:
		vertical_cut(maze, row, column, height, width, with_rooms)

static func apply_algorithm(maze, with_rooms: bool) -> void:
	for row in maze.ROWS:
		for column in maze.COLUMNS:
			var current_cell = maze.indexed_cells[row][column]
			for neighbour in maze.get_neighbours_of(current_cell):
				maze.link_cells(current_cell, neighbour)
	divide(maze, 0, 0, maze.ROWS, maze.COLUMNS, with_rooms)
