class_name BinaryTree

static func apply_algorithm(maze) -> void:
	for row in maze.ROWS:
		for cell in maze.indexed_cells[row]:
			var candidate_neighbours = []
			if maze.north_exists(cell):
				candidate_neighbours.append(maze.get_north_cell_of(cell))
			if maze.east_exists(cell):
				candidate_neighbours.append(maze.get_east_cell_of(cell))
			if !candidate_neighbours.empty():
				var random_candidate = Utils.get_random_elem(candidate_neighbours)
				maze.link_cells(cell, random_candidate)
